//
//  ContentView.swift
//  Instafilter
//
//  Created by Matthew Hanlon on 3/4/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @AppStorage("useCount") var useCount = 0
    @Environment(\.requestReview) var requestReview

    @State private var selectedItem: PhotosPickerItem?
    @State private var beginImage: CIImage?
    @State private var processedImage: Image?

    @State private var filtersEnabled = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false

    @State private var filterIntensity = 0.5
    @State private var filterRadius = 50.0
    @State private var filterCount = 6.0
    @State private var filterAngle = 3.14
    @State private var filterScale = 50.0
    @State private var filterCenterX: CGFloat = 150
    @State private var filterCenterY: CGFloat = 150

    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                .onChange(of: processedImage) { filtersEnabled = processedImage != nil }

                Spacer()

                VStack {
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity, in: 0...10, step: 0.1)
                                .onChange(of: filterIntensity, applyProcessing)
                        }
                        .padding(.vertical)
                    }

                    if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius, in: 1...5000, step: 50)
                                .onChange(of: filterRadius, applyProcessing)
                        }
                        .padding(.vertical)
                    }

                    if currentFilter.inputKeys.contains(kCIInputAngleKey) {
                        HStack {
                            Text("Angle")
                            Slider(value: $filterAngle, in: 1...180, step: 1)
                                .onChange(of: filterAngle, applyProcessing)
                        }
                        .padding(.vertical)
                    }

                    if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale, in: 1...100, step: 0.5)
                                .onChange(of: filterScale, applyProcessing)
                        }
                        .padding(.vertical)
                    }

                    if currentFilter.inputKeys.contains("inputCount") {
                        HStack {
                            Text("Count")
                            Slider(value: $filterCount, in: 1...25, step: 1)
                                .onChange(of: filterCount, applyProcessing)
                        }
                        .padding(.vertical)
                    }

                    HStack {
                        Button("Change filter", action: changeFilter)

                        Spacer()

                        if let processedImage {
                            ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                        }
                    }
                }
                .disabled(selectedItem == nil)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Invert Colors") { setFilter(CIFilter.colorInvert()) }
                Button("Twisty") { setFilter(CIFilter.twirlDistortion()) }
                Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func changeFilter() {
        showingFilters = true
    }

    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()

        useCount += 1
        if useCount >= 20 {
            requestReview()
            useCount = 0
        }
    }

    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            filterCenterX = inputImage.size.width / 2
            filterCenterY = inputImage.size.height / 2

            beginImage = CIImage(image: inputImage)
            
            await setFilter(currentFilter)
        }
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputAngleKey) { currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale, forKey: kCIInputScaleKey) }
        if inputKeys.contains("inputCount") { currentFilter.setValue(filterCount, forKey: "inputCount") }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: filterCenterX, y: filterCenterY), forKey: kCIInputCenterKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
