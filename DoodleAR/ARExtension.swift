//
//  ARExtension.swift
//  DoodleAR
//
//  Created by Cho Youngjin on 2021/07/30.
//

import ARKit

extension SCNNode {
    func addChildNodeWithCam(_ to: SCNNode, view: ARSCNView, cameraRelativePosition: SCNVector3) {
        guard let currentFrame = view.session.currentFrame else { return }
        let cam = currentFrame.camera
        let transform = cam.transform
        var translationMatrix = matrix_identity_float4x4
        
        translationMatrix.columns.3.x = cameraRelativePosition.x
        translationMatrix.columns.3.y = cameraRelativePosition.y
        translationMatrix.columns.3.z = cameraRelativePosition.z
        
        let modifiedMatrix = simd_mul(transform, translationMatrix)
        self.simdTransform = modifiedMatrix
        to.addChildNode(self)
    }
}
