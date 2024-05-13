//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import connectivity_plus
import package_info_plus
import path_provider_foundation
import screen_retriever
import shared_preferences_foundation
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
