//
//  HomeViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Factory
import Combine
import NetworkService
import Foundation

@MainActor
public final class HomeViewModel: ObservableObject {
  
  // MARK: Published subject
  @Published public private(set) var pokemons: [PokemonDomainModel] = []
  @Published public private(set) var isLoading: Bool = false
  @Published public private(set) var errorMessage: String?
  
  // MARK: Dependency Injection
  @Injected(\.getPokemonListUseCase) private var getPokemonUseCase: GetPokemonUseCaseInterface
  
  // MARK: Private properties
  private var cancellables = Set<AnyCancellable>()
  
  public init() {}
  
  // Async entry point retained for callers using async/await.
  public func getPokemonList() async {
    isLoading = true
    errorMessage = nil
    
    pokemonListPublisher()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        guard let self else { return }
        self.isLoading = false
        if case .failure(let error) = completion {
          self.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] list in
        
        print("fetched pokemons \(list)")
        self?.pokemons = list
      }
      .store(in: &cancellables)
  }
  
  // Combine publisher that bridges the async use case to Combine
  private func pokemonListPublisher() -> AnyPublisher<[PokemonDomainModel], Error> {
    // Capture the injected dependency locally to avoid sending a non-Sendable property across an await.
    let useCase = getPokemonUseCase
    return Future<[PokemonDomainModel], Error> { promise in
      Task {
        let result = await useCase.execute()
        promise(.success(result))
      }
    }
    .eraseToAnyPublisher()
  }
  
  public func callNetwork() async {
    isLoading = true
    errorMessage = nil
    
    networkExamplePublisher()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        guard let self else { return }
        self.isLoading = false
        if case .failure(let error) = completion {
          self.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] fetched in
        self?.pokemons = fetched
        print("fetched pokemons \(fetched)")
      }
      .store(in: &cancellables)
  }
  
  private func networkExamplePublisher() -> AnyPublisher<[PokemonDomainModel], Error> {
    Future<[PokemonDomainModel], Error> { promise in
      Task {
        let fetched = await PokemonExampleRunner.runExample()
        promise(.success(fetched))
      }
    }
    .eraseToAnyPublisher()
  }
}
