//
//  DrawStar.swift
//  DesenhoEstrela
//
//  Created by Andre R Fossalussa on 07/03/2018.
//  Copyright © 2018 ARF. All rights reserved.
//
import UIKit

@IBDesignable
class StarView : UIView {
    
    @IBInspectable
    var pontasDaEstrela  : Int     = 5
    
    @IBInspectable
    var raioCirculoMenor: CGFloat = 50.0
    
    @IBInspectable
    var strokeColor     : UIColor = UIColor.black
    
    @IBInspectable
    var fillerColor     : UIColor = UIColor.cyan
    
    var lineWidth       : CGFloat = 3
    
    var path            : UIBezierPath!
    
    func apontarPara(angulo : CGFloat , raio : CGFloat , posicao : CGPoint) -> CGPoint {
        return CGPoint(x : raio * cos(angulo) + posicao.x , y : raio * sin(angulo) + posicao.y)
    }
    
    override func draw(_ rect: CGRect) {
        
        if pontasDaEstrela < 2 {
            pontasDaEstrela = 2
        }
        let path = UIBezierPath()
        let centroRetangulo = CGPoint(x:rect.width / 2.0, y:rect.height / 2.0)
        var angulo:CGFloat = -CGFloat(Double.pi / 2.0)
        let aumentoDoAngulo = CGFloat(Double.pi * 2.0 / Double(pontasDaEstrela))
        var raioCirculoMaior = rect.width / 2.0
        
        if rect.width > rect.height {
            raioCirculoMaior = rect.height / 2.0
        }
        
        if raioCirculoMenor > raioCirculoMaior {
            raioCirculoMenor = raioCirculoMaior
        } else if raioCirculoMenor < 0 {
            raioCirculoMenor = 0
        }
        
        let primeiraPonta = apontarPara(angulo:angulo, raio: raioCirculoMaior, posicao: centroRetangulo)
        
        path.move(to:primeiraPonta)
        
        for _ in 1...pontasDaEstrela {
            
            let proximaPonta = apontarPara(angulo:angulo + aumentoDoAngulo, raio: raioCirculoMaior, posicao: centroRetangulo)
            let pontaCirculoMenor = apontarPara(angulo:angulo + aumentoDoAngulo / 2.0, raio: raioCirculoMenor, posicao: centroRetangulo)
            
            path.addLine(to:pontaCirculoMenor)
            path.addLine(to:proximaPonta)
            
            angulo += aumentoDoAngulo
        }
        
        path.close()
        
        strokeColor.setStroke()
        fillerColor.setFill()
        
        path.lineWidth = self.lineWidth
        path.fill()
        path.stroke()
        
    }
    
}
