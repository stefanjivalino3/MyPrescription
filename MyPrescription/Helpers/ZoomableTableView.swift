//
//  ZoomableTableView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 27/05/23.
//

import UIKit

public protocol ZoomableTableViewCell: UITableViewCell {
    var zoomableView: ZoomableView { get }
}

public class ZoomableTableView: UITableView {
    public func stopZooming() {
        for cell in visibleCells {
            if let cell = cell as? ZoomableTableViewCell {
                cell.zoomableView.reset()
            }
        }
    }

    /// make sure to stop zooming before reload data
    public override func reloadData() {
        stopZooming()
        super.reloadData()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(disableScroll(_:)),
            name: ZoomableNotification.didZoom,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(enableScroll(_:)),
            name: ZoomableNotification.didZoom,
            object: nil
        )
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(disableScroll(_:)),
            name: ZoomableNotification.didZoom,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(enableScroll(_:)),
            name: ZoomableNotification.didZoom,
            object: nil
        )
    }
    
    /// make sure to disable scrolling before begin zooming
    @objc private func disableScroll(_ notification: NSNotification?) {
        if let userInfo = notification?.userInfo,
           let view = userInfo["view"] as? ZoomableView,
           view.isDescendant(of: self) {
            isScrollEnabled = false
        }
    }
    
    /// make sure to enable scrolling after stop zooming
    @objc private func enableScroll(_ notification: NSNotification?) {
        if let userInfo = notification?.userInfo,
           let view = userInfo["view"] as? ZoomableView,
           view.isDescendant(of: self) {
            isScrollEnabled = true
        }
    }
}

