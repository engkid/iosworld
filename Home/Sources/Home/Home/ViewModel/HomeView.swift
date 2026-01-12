import SwiftUI

public struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  
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
              ForEach(viewModel.pokemons.indices, id: \.self) { index in
                let pokemon = viewModel.pokemons[index]
                HStack {
                  Text("\(pokemon.name)")
                  Spacer()
                  if viewModel.isLoading { ProgressView().scaleEffect(0.8) }
                }
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
