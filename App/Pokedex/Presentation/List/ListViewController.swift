//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/23.
//

import UIKit

class ListViewController<T: ListViewModel>: UIViewController {
    
    private var viewModel: T!
    private var baseView: ListView<T>!
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoadingState()
    }
}

// MARK: Bind
extension ListViewController {
    
    func bindLoadingState() {
        viewModel.loadingState.signal.observeValues { [weak self] (loadingState) in
            
            guard let self = self else { return }
            
            switch loadingState {
            case .loading(nextPage: false):
                self.dismissLoading = WindowLoadingView.show()
                
            case .loading(nextPage: true):
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: true)
                
            case .success:
                self.dismissLoading?()
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            case .failure(let error):
                self.dismissLoading?()
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                self.showErrorAlert(error: error)
                
            default:
                break
            }
        }
    }
}

// MARK: Error
extension ListViewController {
    
    func showErrorAlert(error: AnyLoadingState.Failure) {
        let alertController = UIAlertController(title: error.title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: error.actionName, style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}



class ListView<T: ListViewModel>: UIView {
    
    
    func showNextPageLoadingIndicator(isLoadingNextPage: Bool) {
        
    }
}
