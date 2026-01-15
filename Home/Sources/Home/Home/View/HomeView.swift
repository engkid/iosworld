import SwiftUI
import Combine

enum PokemonFilter: String, CaseIterable, Identifiable, Hashable {
  case grass, fire, water, electric, psychic, rock, ground, bug, normal, poison, ghost, dragon, ice, fairy, fighting, flying, steel, dark
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
}

final class SearchState: ObservableObject {
  @Published var query: String = ""
}

public struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  @StateObject private var search = SearchState()
  @State private var debouncedQuery: String = ""
  @State private var cancellables = Set<AnyCancellable>()
  @State private var selectedFilters: Set<PokemonFilter> = []
  
  private var filteredPokemons: [Pokemon] {
    let activeQuery = debouncedQuery
    let base = viewModel.pokemons
    let queried: [Pokemon]
    if activeQuery.isEmpty {
      queried = base
    } else {
      queried = base.filter { $0.name.localizedCaseInsensitiveContains(activeQuery) }
    }
    // If no filters selected, return queried results
    guard !selectedFilters.isEmpty else { return queried }
    // Example filter logic: match by type names on Pokemon if available; otherwise demo using name contains
    return queried.filter { pokemon in
      // If your Pokemon model has a `types: [String]` or similar, replace the line below accordingly
      let name = pokemon.name.lowercased()
      return selectedFilters.contains { filter in
        // Placeholder matching: treat filter name appearing in pokemon name as match
        name.contains(filter.rawValue)
      }
    }
  }
  
  @ViewBuilder
  private var chipFilterBar: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        ForEach(PokemonFilter.allCases, id: \.self) { filter in
          let isSelected = selectedFilters.contains(filter)
          Button(action: {
            if isSelected {
              selectedFilters.remove(filter)
            } else {
              selectedFilters.insert(filter)
            }
          }) {
            HStack(spacing: 6) {
              Text(filter.title)
                .font(.subheadline)
                .padding(.horizontal, 10)
            }
            .background(
              Capsule().fill(isSelected ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.12))
            )
            .overlay(
              Capsule().stroke(isSelected ? Color.accentColor : Color.secondary.opacity(0.35), lineWidth: isSelected ? 1.5 : 1)
            )
          }
          .buttonStyle(.plain)
          .foregroundStyle(isSelected ? Color.accentColor : Color.primary)
          .accessibilityLabel("Filter \(filter.title)")
          .accessibilityAddTraits(isSelected ? .isSelected : [])
        }
      }
      .padding(.horizontal)
    }
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
            // Chip filter header that scrolls with content
            if !(viewModel.isLoading && viewModel.pokemons.isEmpty) {
              Section {
                EmptyView()
              } header: {
                chipFilterBar
              }
            }
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

enum PokemonPath: Int, Hashable {
  case pokemonDetail = 0
}

#Preview {
  HomeView()
}

