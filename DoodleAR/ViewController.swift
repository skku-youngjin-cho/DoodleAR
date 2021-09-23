//
//  ViewController.swift
//  DoodleAR
//
//  Created by Cho Youngjin on 2021/07/24.
//

import UIKit
import ARKit
import LBTAComponents

class ViewController: UIViewController {
    
    // MARK: - LET
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    
    let arView = ARSCNView()
    
    let drawButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(drawButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.backgroundColor = .red
        
        return button
    }()
    
    @objc func drawButtonTapped(sender: UIButton) {
        print("Tapped")
    }
    
    // MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.showsStatistics = true
        
        layout()
        attribute()
    }
    
    // MARK: - layout
    func layout() {
        layoutARView()
        layoutDrawButton()
    }
    
    func layoutARView() {
        view.addSubview(arView)
        
        arView.fillSuperview()
    }
    
    func layoutDrawButton() {
        view.addSubview(drawButton)
        
        drawButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 48, rightConstant: 24, widthConstant: 30, heightConstant: 30)
    }
    
    // MARK: - attribute
    func attribute() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        
        arView.session.run(config, options: [])
        
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        arView.autoenablesDefaultLighting = true
        arView.delegate = self
    }
    
    // MARK: - DRAW
    
    func draw() {
        let dotNode = SCNNode()
        
        dotNode.geometry = SCNSphere(radius: 0.0025)
        dotNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        dotNode.name = "dot"
        
        dotNode.addChildNodeWithCam(arView.scene.rootNode, view: arView, cameraRelativePosition: cameraRelativePosition)
    }
}

//MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
            if self.drawButton.isHighlighted {
                self.draw()
            }
        }
    }
}
