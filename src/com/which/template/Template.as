﻿package com.which.template
			init();
				//dataURL = "http://test.c-lab.co.uk/services/asset.php?contentid=3";
					Console.log( dataURL, this);			
			
			
			
			try 
			
			if (data.image_1!=null)
				imgs.push(data.image_1);
			if (data.image_2!=null)
				imgs.push(data.image_2);
				Console.log("Bitmap: "+(e.target).url,this);
				
				try
				{
					bitmap = Bitmap( e.target.loader.content );
					bitmap.smoothing = true;
					imageHolder.img.bg.visible = false;
					var scaleFactor:Number = Math.min(imageHolder.img.bg.width/bitmap.width, imageHolder.img.bg.height/bitmap.height); 
					bitmap.scaleX = bitmap.scaleY = scaleFactor;
					imageHolder.img.addChild(bitmap);	
				} catch (error:Error)
				{
					Console.log("Error: "+error.message, this);
				}									