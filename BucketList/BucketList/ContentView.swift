//
//  ContentView.swift
//  BucketList
//
//  Created by Matthew Hanlon on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        VStack {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
            
            Button("Reload") {
                Task {
                    await load()
                }
            }
            .disabled(loadingState == .loading)
        }.task {
            await load()
        }
    }
    
    func load() async {
        loadingState = .loading
        do {
            try await Task.sleep(nanoseconds: 5_000_000_000)
            
            loadingState = Bool.random() ? .success : .failed
        } catch {
            loadingState = .failed
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

#Preview {
    ContentView()
}
