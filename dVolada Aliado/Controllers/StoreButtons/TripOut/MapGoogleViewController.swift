//
//  MapGoogleViewController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 13/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import GooglePlaces


class MApGoogleViewController: UIViewController {

      var resultsViewController: GMSAutocompleteResultsViewController?
      var searchController: UISearchController?
      var resultView: UITextView?

      override func viewDidLoad() {
        super.viewDidLoad()

        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))

        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
      }
    }

    // Handle the user's selection.
    extension MApGoogleViewController: GMSAutocompleteResultsViewControllerDelegate {
      func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                             didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
      }

      func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                             didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
      }

      // Turn the network activity indicator on and off again.
      func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }

      func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
}