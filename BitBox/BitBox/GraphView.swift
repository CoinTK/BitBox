//
//  GraphView.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/24/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit



@IBDesignable class GraphView: UIView {
        
        //Weekly sample data
        var graphPoints:[Int] = []
        let api = ""
    
        //1 - the properties for the gradient
        @IBInspectable var startColor: UIColor = UIColor.red
        @IBInspectable var endColor: UIColor = UIColor.green
        
        override func draw(_ rect: CGRect) {
            getJson(url: api)
            
            
            let width = rect.width
            let height = rect.height
            
            //set up background clipping area
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: UIRectCorner.allCorners,
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
            path.addClip()
            
            
            //2 - get the current context
            let context = UIGraphicsGetCurrentContext()
            let colors = [startColor.cgColor, endColor.cgColor]
            
            //3 - set up the color space
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            //4 - set up the color stops
            let colorLocations:[CGFloat] = [0.0, 1.0]
            
            //5 - create the gradient
            let gradient = CGGradient(colorsSpace: colorSpace,
                                      colors: colors as CFArray,
                                      locations: colorLocations)
            
            //6 - draw the gradient
            let startPoint = CGPoint(x: 0,y :0)
            let endPoint = CGPoint(x:0, y:self.bounds.height)
            context!.drawLinearGradient(gradient!,
                                        start: startPoint, 
                                        end: endPoint, 
                                        options: CGGradientDrawingOptions(rawValue: 0))
            //calculate the x point
            let margin:CGFloat = 20.0
            let columnXPoint = { (column:Int) -> CGFloat in
                //Calculate gap between points
                let spacer = (width - margin*2 - 4) /
                    CGFloat((self.graphPoints.count - 1))
                var x:CGFloat = CGFloat(column) * spacer
                x += margin + 2
                return x
            }
            
            // calculate the y point
            
            let topBorder:CGFloat = 60
            let bottomBorder:CGFloat = 50
            let graphHeight = height - topBorder - bottomBorder
            let maxValue = graphPoints.max()
            let columnYPoint = { (graphPoint:Int) -> CGFloat in
                var y:CGFloat = CGFloat(graphPoint) /
                    CGFloat(maxValue!) * graphHeight
                y = graphHeight + topBorder - y // Flip the graph
                return y
            }
            
            // draw the line graph
            
            UIColor.white.setFill()
            UIColor.white.setStroke()
            
            //set up the points line
            let graphPath = UIBezierPath()
            //go to start of line
            graphPath.move(to:
                CGPoint(x:columnXPoint(0),
                                          y:columnYPoint(graphPoints[0])))
            
            //add points for each item in the graphPoints array
            //at the correct (x, y) for the point
            for i in 1..<graphPoints.count {
                let nextPoint = CGPoint(x:columnXPoint(i),
                                        y:columnYPoint(graphPoints[i]))
                graphPath.addLine(to: nextPoint)
            }
            
            graphPath.stroke()
            
            //Draw horizontal graph lines on the top of everything
            var linePath = UIBezierPath()
            
            //top line
            linePath.move(to: CGPoint(x:margin, y: topBorder))
            linePath.addLine(to: CGPoint(x: width - margin,
                                            y:topBorder))
            
            //center line
            linePath.move(to: CGPoint(x:margin,
                                         y: graphHeight/2 + topBorder))
            linePath.addLine(to: CGPoint(x:width - margin,
                                            y:graphHeight/2 + topBorder))
            
            //bottom line
            linePath.move(to: CGPoint(x:margin,
                                         y:height - bottomBorder))
            linePath.addLine(to: CGPoint(x:width - margin,
                                            y:height - bottomBorder))
            let color = UIColor(white: 1.0, alpha: 0.3)
            color.setStroke()
            
            linePath.lineWidth = 1.0
            linePath.stroke()
        }
    
        func getJson(url: String) {
        
        }

}
