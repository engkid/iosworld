import SwiftUI
import Combine

final class SearchState: ObservableObject {
  @Published var query: String = ""
}

public struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  @StateObject private var search = SearchState()
  @State private var debouncedQuery: String = ""
  @State private var cancellables = Set<AnyCancellable>()
  
  private var filteredPokemons: [Pokemon] {
    let activeQuery = debouncedQuery
    guard !activeQuery.isEmpty else { return viewModel.pokemons }
    return viewModel.pokemons.filter { $0.name.localizedCaseInsensitiveContains(activeQuery) }
  }
  
  public init() {}
  
  public var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading && viewModel.pokemons.isEmpty {
          ProgressView("Loading…")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage, viewModel.pokemons.isEmpty {
          VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
              .font(.largeTitle)
              .foregroundStyle(.orange)
            Text(error)
              .multilineTextAlignment(.center)
              .foregroundStyle(.secondary)
            Button("Retry") {
              Task { await viewModel.getPokemonList() }
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
        } else {
          List {
            if let error = viewModel.errorMessage, !error.isEmpty {
              Section {
                HStack(spacing: 8) {
                  Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.orange)
                  Text(error)
                }
              }
            }
            Section {
              ForEach(filteredPokemons.indices, id: \.self) { index in
                let pokemon = filteredPokemons[index]
                HStack {
                  Text("\(pokemon.name)")
                  Spacer()
                  if viewModel.isLoading { ProgressView().scaleEffect(0.8) }
                }
              }
              if filteredPokemons.isEmpty && !debouncedQuery.isEmpty {
                ContentUnavailableView("No Results", systemImage: "magnifyingglass", description: Text("No Pokémon match “\(debouncedQuery)”."))
              }
            }
          }
          .listStyle(.insetGrouped)
        }
      }
      .navigationTitle("Pokémon")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          if viewModel.isLoading {
            ProgressView().controlSize(.small)
          } else {
            Button {
              Task { await viewModel.getPokemonList() }
            } label: {
              Image(systemName: "arrow.clockwise")
            }
            .accessibilityLabel("Refresh")
          }
        }
      }
      .task {
        if viewModel.pokemons.isEmpty && !viewModel.isLoading {
          await viewModel.getPokemonList()
        }
      }
      .refreshable {
        await viewModel.getPokemonList()
      }
      .onAppear {
        // Clear previous subscriptions in case the view reappears
        cancellables.removeAll()
        search.$query
          .removeDuplicates()
          .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
          .sink { value in
            debouncedQuery = value
          }
          .store(in: &cancellables)
      }
      .searchableOnAppear(
        $search.query,
        prompt: "Search pokemon",
        placement: .navigationBarDrawer(displayMode: .always),
        onSubmit: { submitted in
          // Snap immediately on submit
          debouncedQuery = submitted
        }
      )
      // MARK: Navigation example using SwiftUI Navigation Stack
      .navigationDestination(for: PokemonPath.self) { route in
        switch route {
        case .pokemonDetail:
          EmptyView()
        }
      }
    }
  }
}

struct HeightPreferenceKey {
  
}

enum PokemonPath: Int, Hashable {
  case pokemonDetail = 0
}

#Preview {
  HomeView()
}
