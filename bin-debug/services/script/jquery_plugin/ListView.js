// JavaScript Document

(function($) {


    $.fn.ListView = function(options) {
	var $obj = $(this);
	var data = null;
	var tag = null;
	var key = '';
	var mode = "view";
	var page_to = 1;
	var page_from = 0;
	var itemcount = 5;
	var editMode = -1;
	var id = -1;
	var pid = -1;
	var UTCOffset = -2;
	var includeSelf = false;
	var thresholdMargin = 0;
	var triggerPageThreshold = 5;
	var customLoaderProc = false;
	var custome_loader  = "<img src='img/loader.gif'/>";
	var util             = new $.ias.util();   
	var setupReady = false;
	if (options!=null)
	{
		tag = options.tag;
		id = options.id;
		pid = options.pid;
		editMode = options.editMode;
		mode = options.mode;
	}

	var lastId = -1;
	var loadURL;
	var $item;
	var pageChange = false;
	
	var init = function ()
	{
		$item = $obj.find(".items .item:first");
		$obj.bind("update", update);
		//$obj.find(".items").scroll(scroll_handler);;
		
		
	
		/*
		if (!setupReady)
		{
			jQuery.ias({
				container : '#'+$obj.attr("id")+' '+'.items',
				item: '.item',
				pagination:  '#'+$obj.attr("id")+' '+'.navigation',
				next: '.next-posts a',
				loader: '<img src="img/loader.gif"/>'
			});
		}
			
		setupReady = true;
		*/
	}
	 function get_scroll_threshold(pure)
        {
            var el,
                threshold;

            el = $obj.find(".item").last();
            if (el.size() === 0) {
                return 0;
            }

            threshold = el.offset().top + el.height();

            if (!pure) {
                threshold += thresholdMargin;
            }

            return threshold;
        }
	function get_current_page()
	{
		return page_to;
	}
	
	 function scroll_handler()
        {
			
			
            var curScrOffset,
                scrThreshold;

            curScrOffset = util.getCurrentScrollOffset($(window));
            scrThreshold = get_scroll_threshold();
		//	alert(curScrOffset+" "+scrThreshold)
			var top = $('html').offset().top;
			var changed = false;
			var selectedValue = -1;
			//updateAlert("");
			
			$obj.find(".items .item").each( function(i,e)
			{
				//updateAlert($(e).offset().top+"<"+$(document).scrollTop()+"<"+($(e).offset().top+$(e).height())+":"+data[i].name)
				var post_id= $($(e).find("input[name='id']")).attr("value");
				var post_name = $($(e).find("h2")).text();
		
			//	updateAlert( post_name+" "+  $(e).offset().top+'<'+($("body").scrollTop()+$(window).height()) +'&&'+ ( $(e).offset().top+$(e).height() )+'>'+($("body").scrollTop()+$(window).height()) , true);

				
	//			if ($(e).offset().top<$("body").scrollTop() && $(e).offset().top+$(e).height()>$("body").scrollTop()+$(window).height() )
				
				if ($("body").scrollTop()>0 && $(e).offset().top<($("body").scrollTop()+$(window).height() )  &&  ($(e).offset().top+$(e).height())  >  ($("body").scrollTop()+$(window).height()) )
				{
						changed = true;		
						selectedValue = post_id;				
					    threshold = i==$obj.find(".items .item").length-1;
				}
				
				
			});
			if (selectedValue>=0)
			{
				
				//updateAlert(data[selectedIndex].name)
				//updateAlert(threshold)
				changeID(selectedValue, threshold);
				/*show_more_next(5, function () {
					paginate();
				});
				*/
				
			} else
			{
				/*
			updateAlert( curScrOffset +">="+ scrThreshold + ': ' +(curScrOffset >= scrThreshold));
			if (curScrOffset >= scrThreshold) {
				changeID(data[i].id, true);
			
				$obj.find(".items .item").each( function(i,e)
			{
			//	alert($(e).offset().top+"<"+$(document).scrollTop()+"<"+($(e).offset().top+$(e).height())+":"+data[i].name)
			//	updateAlert( $(e).offset().top+'<'+$("body").scrollTop() +'&&'+ ( $(e).offset().top+$(e).height() )+'>'+$("body").scrollTop() );
				if (  $(e).offset().top<($("body").scrollTop()+$(window).height() )  &&  ($(e).offset().top+$(e).height())  >  ($("body").scrollTop()+$(window).height())  )
				{
					changeID(data[i].id, true);
				}
				
				
			});
			
				
				
			}
            if (curScrOffset >= scrThreshold) {
				
                if (get_current_page() >= triggerPageThreshold) {
					
                   // stop_scroll();
                    show_trigger(function () {
						
                   //     paginate(curScrOffset);
                    });
					
                }
                else {
                 //   paginate(curScrOffset);
                }
            }
			*/
			}
			
        }
 	
	var changeID = function(id, doLoad)
	{
		
		var cpage =  window.location.hash;
		var chash = $obj.attr("id");
			
		if (cpage!=null)
		{
			if (cpage.indexOf("?")>-1)
			{
				chash = cpage.substr(0, cpage.indexOf("?"));
			} else
			{
				chash = cpage;
			}
		}
	
		hash = chash+'?itemID=' + (Number(id))+(doLoad ? "&load=true" : "");
	//	alert(hash);
		window.location.hash = hash;
	}
	var paginate = function (curScrOffset, onCompleteHandler)
	{
	
		/*
		var cpage =  window.location.hash;
		var chash = $obj.attr("id");
			
		if (cpage!=null)
		{
			if (cpage.indexOf("?")>-1)
			{
				chash = cpage.substr(0, cpage.indexOf("?"));
			} else
			{
				chash = cpage;
			}
		}
		
//		var urlNextPage = $obj.find(".next-posts a").attr("href"); 
//		alert(hash)
//		next_page = urlNextPage.split("to=")[urlNextPage.split("to=").length-1],urlNextPage
		hash = chash+'?to=' + (Number(page_to) +1);
		
		window.location.hash = hash;
	  */
        

	}
	function stop_scroll()
        {
           $(window).unbind('scroll', scroll_handler);
        }
 	function start_scroll()
     {
		// alert('')
		
			$(window).scroll(scroll_handler);;
      }
	function get_loader()
        {
            var loader = $('.ias_loader');

            if (loader.size() === 0) {
                loader = $('<div class="ias_loader">' + custome_loader + '</div>');
                loader.hide();
            }
            return loader;
        }

function hide_loader() 
{
	var loader = get_loader(),
			el;
		
	loader.hide();
	
}
	 function show_loader()
	{
		var loader = get_loader(),
			el;

		if (customLoaderProc !== false) {
			customLoaderProc(loader);
		} else {
			el = $obj.find(".items");
			el.after(loader);
			loader.fadeIn();
		}
	}
	function get_trigger(callback)
        {
            var trigger = $('.ias_trigger');

            if (trigger.size() === 0) 
			{
                trigger = $('<div class="ias_trigger"><a href="#";>Load more items</a></div>');
                trigger.hide();
            } 
			trigger.find("a").attr("href", '#'+$obj.attr('id')+'?to='+(Number(page_to)+1));
            $('a', trigger)
                .off('click')
                .on('click', function () { remove_trigger(); callback.call(); return false; })
            ;

            return trigger;
        }
		function get_more_previous(number, callback)
        {
            var trigger = $('.ias_more_previous');

            if (trigger.size() === 0) 
			{
                trigger = $('<div class="ias_more_previous"><a href="#";>Load '+(number>triggerPageThreshold ? '+'+triggerPageThreshold : number)+' newer items</a></div>');
                trigger.hide();
            } 
		
			trigger.find("a").attr("href", '#'+$obj.attr('id')+'?itemID='+ data[0].id+'&load=true&method=next&count='+(number>triggerPageThreshold ? triggerPageThreshold : number));
            $('a', trigger)
                .off('click')
                .on('click', function () { remove_trigger(); callback.call(); return false; })
            ;

            return trigger;
        }
		function get_more_next(number, callback)
        {
            var trigger = $('.ias_more_next');

            if (trigger.size() === 0) 
			{
                trigger = $('<div class="ias_more_next"><a href="#";>Load '+(number>triggerPageThreshold ? '+'+triggerPageThreshold : number)+' older items</a></div>');
                trigger.hide();
            } 
		
			trigger.find("a").attr("href", '#'+$obj.attr('id')+'?itemID='+ data[data.length-1].id+'&load=true&method=previous&count='+(number>triggerPageThreshold ? triggerPageThreshold : number));
            $('a', trigger)
                .off('click')
                .on('click', function () { remove_trigger(); callback.call(); return false; })
            ;

            return trigger;
        }
		
	function hide_more_previous()
	{
		$('.ias_more_previous').hide();
	}
	function hide_more_next()
	{
		$('.ias_more_next').hide();
	}
	function show_more_previous(number, callback)
	{
		//alert(data.length+" "+page_to*itemcount)
		
		
		  var trigger = get_more_previous(number, callback),
                el;
            el = $obj.find(".items");
            el.before(trigger);
            trigger.fadeIn();
	}
	function show_more_next(number, callback)
	{
		//alert(data.length+" "+page_to*itemcount)
		
		
		  var trigger = get_more_next(number, callback),
                el;
            el = $obj.find(".items");
            el.after(trigger);
            trigger.fadeIn();
	}
	function show_trigger(callback)
        {
            var trigger = get_trigger(callback),
                el;

           el = $obj.find(".items");
            el.after(trigger);
            trigger.fadeIn();
        }

	var update = function(e,t) {
		tag = (t.tag);
		id = t.id;
		pid = t.pid;
		editMode = t.editMode;
		mode = t.mode;
		key = t.key;
	//	haschanged = page_to!=t.page_to || t.page_to==null;
		pageChange = false;
		
		if (t.itemID==null)
		{
		if (t.to == null)
		{
			load('all',triggerPageThreshold);
		} else {
			
			pageChange = true;
			page_to = t.to;
			page_from = t.from==null ? (t.to) : t.from;
			//alert(page_from+"---"+page_to)
			load('all', triggerPageThreshold);
			
			
		}
		} else
		{
			
			
			if (t.load)
			{
				pageChange = true;
				page_to = 0;
				includeSelf = false;
				id = t.itemID;
				//alert(t.itemID);
				
				load(t.method==null ? 'previous' : t.method, t.count==null ? 2 : t.count);
			} 
			if (data==null)
			{
				pageChange = true;
				
				id = t.itemID;
				includeSelf = true;
			//	alert(page_from)
				load('previous',triggerPageThreshold);
			}
			
		}
	
	}
	
	var load = function (method, count)
	{
	hide_more_previous();
		show_loader();
		 //$("#content .loading").stop(true,true).show();
		 	stop_scroll();
		if (!pageChange)
		 clear();
		 if (loadURL!=null) {
			 loadURL.abort();
		 }
	
		 if (id!=-1)
		 {
			 lastId = id;
		 }
		
		//alert("from:"+page_from+" to:"+page_to)
		 loadURL = $.ajax({
                type: "POST",
                url: "list.php",
				dataType: 'json',
				data: { method: method, tag: tag, id: id, count: count, page: page_from, includeSelf: includeSelf },
                success: function(response) {
					
                   if (response) {
				    if (mode == "edit" || mode=="new")
					{
						setupEdit(response);
					} else {
						
						setup(response);
					}
				   }else{
					alert(response);
				   }
					//$("#content .loading").stop(true,true).fadeOut('slow');
                   
                },
                failure: function(msg) {
                  
                    //$('#output').text(msg);
					alert(msg)
                }
            });
			
	}
	
	var clear = function()
	{
		
		$item = $($obj.find(".items .item")[0]).clone();
		$obj.find(".items").empty();
		var $i= $item;
		$item.appendTo($obj.find(".items"));
		$($i.find("h2")[0]).html("");
		$($i.find(".counter")[0]).html("");
		$($i.find(".location")[0]).html("");
		$($i.find(".description")[0]).html("");
		$($i.find(".posted")[0]).html("");
		$($i.find(".startdate")[0]).html("");
		$($i.find(".enddate")[0]).html("");
		$($i.find(".tags")[0]).html("");
		$($i.find("input[name='id']")[0]).attr("value", "-1");
		$i.click( function(e) {});
		
		if (editMode>0)
		{
			$i.find(".editbuttons").show();
			if (lastId>0)
			{	
				//$i.find(".editbuttons .delete").click( function(e) { deleteItem(); } ).show();
			} else
			{
				$i.find(".editbuttons .delete").hide();
			}
			
			
		} else
		{
			$i.find(".editbuttons").hide();
		}
		$i.hide();
		
	}
	
	var setupEdit = function(data_server)
	{
			//comment out when cleaned
		$obj.find(".data").hide();
		
		clear();
		$obj.find(".edit_clean").remove().empty();
		data = data_server;//$.parseJSON(data);
		
		var nowdate = new Date();
		nowdate.setUTCHours(nowdate.getHours());
		var now = (nowdate.getTime())/1000;
		
		for (var i=0;i<1;i++)
		{
				
			var d = data.length==0 || mode=="new" ? {sector: tag, id:-1, posted: now, startdate:now } : data[i];
			
			var $i= $item.clone().appendTo($obj.find(".items"));
			
			
			$i.find(".editbuttons .cancel").show();
					
			$i.find(".editbuttons .cancel").click( function(e) { if (window.confirm("Reset form?")) setupEdit(data); } ).show().css("cursor","hand").attr("href", "javascript:return false;");;
			$i.find(".editbuttons .edit").hide();
			var editLink = "#"+tag+"?id="+d.id+"&mode=edit";
			var newLink =  "#"+tag+"?mode=new";
			$($i.find(".edit")[0]).attr("href",editLink);
			$($i.find(".new")[0]).attr("href",newLink);
			$i.find("input[name='id']").attr("value", d.id);
			if (mode=="edit")
			{	
				
				$i.find(".editbuttons .delete").click( function(e) { var id = ($(e.target).parent().find("input[name='id']").attr("value"));deleteItem(id); } ).show().css("cursor","hand").attr("href", "javascript:return false;");
				$i.find(".editbuttons .new").show();
				
		
			} else
			{
				$i.find(".editbuttons .delete").hide();
				$i.find(".editbuttons .new").hide();
			
			}
			
		//	$($i.find(".counter")[0]).css("background", "none");
			//$i.parent().css("width", "940px");
			//$i.css("width", "940px");
			$($i.find(".circle")[0]).css("background",  "url('img/circle50x50.png') -1px -1px no-repeat");
			$($i.find(".counter")[0]).html( tag.toUpperCase());
		
			var items = [{a: "title", b: "name"}, /*{a: "location", b: "location"},*/ {a: "description", b: "body"},  {a: "start date", b: "startdate", type: "date"}, {a: "end date", b: "enddate", type: "date"},{a: "posted", b: "posted", type: "date"},{a: "location", b: "location"},{a: "tags", b: "tags", type: "list"}];
			for (var j=0;j<items.length;j++)
			{
				
				var $li = $("<label/>").attr("for", items[j].b ).text(  (items[j].a+":").toUpperCase() ).css("width", "120px").css("float","left");
			
				$($i.find("."+items[j].b)[0]).append( $li.clone().attr("value", d[items[j].b]) ).css("margin-top", (j==0) ? "25px" : "5px")//.css("width", "100%");
				
				switch (items[j].b) 
				{
					case "body":
						var $bi = $("<textarea/>").attr("id", items[j].a ).addClass("tinymce");
						$($i.find("."+items[j].a)[0]).append( $bi.clone().text( mode=="new" ? "" : ( d[items[j].b] == undefined ? "" : d[items[j].b]  ) ) );
						//$bi.html( mode=="new" ? "" : ( d[items[j].b] == undefined ? "" : d[items[j].b]  )   ) ;
						//make rich text
							
							//$bi.css("height", 800+"px");
						
							$bi.tinymce({
								// Location of TinyMCE script
								script_url : 'tinymce/jscripts/tiny_mce/tiny_mce.js',
								width: "940",
								height: "400",
								// General options
								
								theme : "advanced",
								relative_urls : true,
								plugins : "autoresize,autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist,autoresize,jbimages",
								// Theme options
								theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
								theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,jbimages",
								theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,insertdate,inserttime",
								theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,|,print,|,ltr,rtl,|,fullscreen,preview,|,forecolor,backcolor",
								
								theme_advanced_toolbar_location : "top",
								theme_advanced_toolbar_align : "left",
								theme_advanced_statusbar_location : "bottom",
								theme_advanced_resizing : true,
        						theme_advanced_resize_horizontal : false,
					
								// Example content CSS (should be your site CSS)
								content_css : "css/layout.css",
					
								// Drop lists for link/image/media/template dialogs
								template_external_list_url : "lists/template_list.js",
								external_link_list_url : "lists/link_list.js",
								external_image_list_url : "lists/image_list.js",
								media_external_list_url : "lists/media_list.js",
								extended_valid_elements : 'iframe[src|style|width|height|scrolling|marginwidth|marginheight|frameborder],style,script'
				
						});
						
					break;
					case "category":
						
						var $bi = $("<select/>").attr("id", items[j].b );
						$($i.find("."+items[j].a)[0]).append( $bi.clone() );
						populateCategory(d.categoryId, $i);
					break;
					default:
						var $bi = $("<input/>").attr("type","text").attr("value", "").attr("id", items[j].b );//.css("width", "500px");
						$($i.find("."+items[j].b)[0]).append( $bi.clone().attr("value", mode=="new" ? "" : ( d[items[j].b] == undefined ? "" : d[items[j].b]  ) ) );
				}
				
				
				if (items[j].type=="date")
				{
					var date =new Date();
					
					if (d[items[j].b]!=null && d[items[j].b]>0) {
						
						date = new Date(d[items[j].b]*1000);
						date.setUTCHours(date.getHours()+UTCOffset);
						
					} 
					
					if (date.getFullYear()>2000 && d[items[j].b]!=null && d[items[j].b]>0) {
						
						$("input#"+items[j].b).val( $.format.date(date, 'dd-MM-yyyy HH:mm') );
					} else {
						$("input#"+items[j].b).val( "" );
					}
					$("input#"+items[j].b).datetimepicker( { timeFormat: "HH:mm", dateFormat: "dd-mm-yy",  timezoneIso8601: true } );
				}
				
				
				
				
			}
		
			$($i.find(".link")[0]).hide();
			$($i.find(".update")[0]).click( function() { updateItem(mode=="new" ? -1 : d.id) }).css("cursor", "hand").attr("href", "javascript:return false;");
			$i.show();
	
			$i.css("width", "100%")
			var topY = ( 50-$i.find(".circle .counter").height() ) / 2;
			var leftX = ( 50-$i.find(".circle .counter").width() ) / 2;
			
			$i.find(".circle .counter").css("position", "relative").css("top", (topY)+"px").css("left", (leftX)+"px");
			
		}

	}
	
	var populateRegion = function(id, $i)
	{
		
		$.ajax({
					type: "POST",
					url: "saveItem.php",
					dataType: 'json',
					data:{method: "getRegions"},
					success: function(response) {   
						for (var i=0;i<response.length;i++)
						{
							
							var opt = $("<option/>").attr("value", response[i]["id"]).text(response[i]["name"]);
							
							if (Number(response[i]["id"]) == Number(id)  &&  mode!="new")
								opt.attr("selected", "true");
								
							
							$i.find(".location select").append(opt);
						}
						var opt = $("<option/>").attr("value", "-1").text("Select region...");
						if (mode=="new")
							$i.find(".location select").prepend(opt);
								
					},
					failure: function(msg) {
						alert(msg);
					},
					error: function(msg) {
						alert(msg.responseText);
					}
		});
		
	}
	
	var populateCategory = function(id, $i)
	{
		
		$.ajax({
					type: "POST",
					url: "saveItem.php",
					dataType: 'json',
					data:{method: "getCategory"},
					success: function(response) {   
						for (var i=0;i<response.length;i++)
						{
							
							var opt = $("<option/>").attr("value", response[i]["id"]).text(response[i]["name"]);
							
							if (Number(response[i]["id"]) == Number(id)  &&  mode!="new")
								opt.attr("selected", "true");
								
							
							$i.find(".category select").append(opt);
						}
						var opt = $("<option/>").attr("value", "-1").text("Select category...");
						if (mode=="new")
							$i.find(".category select").prepend(opt);
								
					},
					failure: function(msg) {
						alert(msg);
					},
					error: function(msg) {
						alert(msg.responseText);
					}
		});
		
	}
	var getDataById = function (id)
	{
		if (data!=null)
		{
			for (var i=0;i<data.length;i++)
			{
				if (data[i].id == id)
					return data[i];
			}
		}
		return null;
	}
	var updateItem = function(id){
			
		var index = 0;
	//	alert($obj.find(".items:last-child")[0].outerHTML)
		var $i= $obj.find(".items:last-child");
		if ($i.length==0)
		{
			 $i= $obj.find(".items .item");
		}
		var dItem = new Object();
		if (id>0) {
			dItem["id"] =  id;
			//if (getDataById(id))
			//	dItem["reference"] =  getDataById(id).reference;
		}
		
		dItem["posted"] =  $i.find(".posted input").attr("value");
		dItem["startdate"] =  $i.find(".startdate input").attr("value");
		dItem["enddate"] =  $i.find(".enddate input").attr("value");
		dItem["name"] =  $i.find(".name input").attr("value");
		dItem["pid"] = pid;
		//dItem["regionId"] =  $i.find(".location select option:selected").val();
		dItem["body"] =   $i.find(".description textarea").val();
		//dItem["sector"] = $i.find(".sector select option:selected").val();
		dItem["location"] =  $i.find(".location input").attr("value");
		dItem["tags"] =  $i.find(".tags input").attr("value");
		dItem["userId"] = editMode;
		dItem["key"]	= key;	
		
		$i.find(".circle .counter").attr("title", $i.find(".circle .counter").text()).text("loading");
		//job["categoryId"] =  $i.find(".category select option:selected").val();
		//job["startdate"] =  $i.find(".startdate input").attr("value");
		//dItem["reference"] =  $i.find(".referenceNum input").attr("value");
	
		
		//print_r(dItem)	
		saveItem(dItem, data, index); 
	}
	var get_obj_date = function (a,b)
	{
		var type= "startdate";
		var d1 = new Date();
		if (a[type]!=null && a[type]>0) {
					d1 = new Date((a[type]*1000));
				//	d1.setUTCHours(a[type].getHours()+UTCOffset);
					
		} 

		var d2 =new Date();
		if (b[type]!=null && b[type]>0) {
					d2 = new Date(b[type]*1000);
				//	d2.setUTCHours(b[type].getHours()+UTCOffset);
		} 
		return {a: d1, b: d2};
	}
	var date_sort_asc = function (a, b) {
		var obj = get_obj_date(a,b);
	//	alert(obj.a)
		a = obj.a;
		b = obj.b;	
		return (a > b) ? 1 : (a < b) ? -1 : 0;
	};
		
	var date_sort_desc = function (a, b) {
		var obj = get_obj_date(a,b)
		a = obj.a;
		b = obj.b;	
		return (a > b) ? -1 : (a < b) ? 1 : 0;
	};
	
	var lookupFirst = function (d)
	{
		
		for (var j=0;j<data.length;j++)
		{
			if (data[j]["shown"])
			{
				return j;
				
			}
				
		}
		return -1;
	}
	var printtable = function (tab, param)
	{
		$('#testtable').remove();
		var $div = $("<div id='testtable' style='position:absolute;z-index:20;top:0px;left:0px;opacity:.5;background-color:#ffffff;font-size:8px;'/>")
		var $table = $("<table cellpadding='10' style=''  />");
		$th= $("<tr/>").appendTo($table);
		$("<td/>").text("index").appendTo($th);
		var paramTab = param == null ? tab[0] : param
	
		for (var m in paramTab) {
				
				$("<td/>").text(m).appendTo($th);	
			
		}
		
		for (var j=0;j<tab.length;j++)
		{
			$tr= $("<tr/>").appendTo($table);
			
			$("<td/>").text(j).appendTo($tr);
			
			
	
			for (var m in param) {
				
				$("<td/>").text(m=="startdate" ? new Date(1000*Number(tab[j][m])) : tab[j][m]).appendTo($tr);	
			}						
		}
	
		$("body").prepend($div.prepend($table))
	}
	
	var setup = function(_data)
	{
			//comment out when cleaned
		//$obj.find(".data").hide();
		var itemsAfter = _data.length>0 ?  Number(_data[0]["after"])  : 0;
		var itemsBefore = _data.length>0 ?  Number(_data[0]["before"])  : 0;

		var isOverlap = true;
		
		if (data!=null)
		{
			for (var i=0;i<_data.length;i++)
			{
				var found = false;
				for (var j=0;j<data.length;j++)
				{
					
					if (_data[i]["id"] == data[j]["id"])
					{
						found = true;
						
					}
				}
				if (!found)
				{
					isOverlap = false;
					_data[i].shown = false;
				}
			}
		}
		var currScroll = $("body").scrollTop();
	
		if (_data.length>0 || !isOverlap)
		{
			
		//	clear();
		//	$obj.find(".edit_clean").remove().empty();
					
			
			data = data==null ? _data : data.concat_unique(_data, "id");//$.parseJSON(data);
				
	
			data.sort(date_sort_desc);
			printtable(data, {id:null, name:null, shown:null, startdate: null, before:null, after: null});
			//for (var m in data[0])
			//	alert(m+" "+data[0][m])
			//saveItems(data);
			
			if (!pageChange)
			{
				$obj.find("h1:first-child").show();
				//$obj.find("#info").show();
				$obj.find(".edit_clean").remove().empty();
			}
	
			if (data.length==0)
			{
				
				if (editMode>0)
				{
					var $i= $item.clone().appendTo( $obj.find(".items") );
					var newLink =  "#"+tag+"?mode=new"; 
					$($i.find(".new")[0]).attr("href",newLink);
					$i.find(".editbuttons .update").hide();
					$i.find(".editbuttons .edit").hide();
					$i.find(".editbuttons .cancel").hide();
					
					$obj.append($("<div/>").addClass("edit_clean").append($i.find(".editbuttons").clone().find(".new").text("Create new...")));
				}
			}
			
			
	//		alert($obj.find(".items")[0].outerHTML)
			
			var firstShownIndex = lookupFirst(d);
			for (var i=0;i<data.length;i++)
			{
				
				var d = data[i];
			
				//alert((new Date(d.startdate*1000))+" "+d.name);
				//var condition = $obj.find(".items").find("input[name='id'][value='"+d.id+"']").size();
				//alert((!d.shown ? "show" : "already there") + " "+d.name+" "+"input[name='id'][value='"+d.id+"']")
			
			 if ( !d.shown ) {
				
				
				var $i= $item.clone();
				
				//alert(data[i==0 ? 0 : i-1].name+" "+d.name)
				
				//	this is a new item that has not been shown before
				//	but where do we add it? We need to find its closest item and deside if we are adding it before or after
				//	To find the first item already shown we can do the following
				
				
				if (firstShownIndex!=-1)
				{
					
					//$obj.find(".items .item:first").before($i);	
					var isPreviousShown = data[i-1]==null ? false : data[i-1].shown;
					var isNextShown = data[i+1]==null ? false : data[i+1].shown;
					var activeItem = $obj.find(".items .item input[name='id'][value="+data[firstShownIndex].id+"]").parent();
					if (i==0)
					{
						activeItem.before( $i );
					} else if (isNextShown) {
						var activeItem = $obj.find(".items .item input[name='id'][value="+data[i+1].id+"]").parent();
						activeItem.before( $i );
					} else if (isPreviousShown)
					{
						var activeItem = $obj.find(".items .item input[name='id'][value="+data[i-1].id+"]").parent();
						activeItem.after( $i );
						
					} else {
					
					}
					
					
					if (firstShownIndex>i)
					{		
						activeItem.before( $i );
					} else 
					{
						activeItem.after( $i );
					}
					
					firstShownIndex = i;
				} 
				else {
					
					$i.appendTo($obj.find(".items"));
				}
			
				d.shown = true;
				
				//d.item = $i;
				$($i.find("h2")[0]).html(d.name);
			
			//	$($i.find(".counter")[0]).css("background", "none");
			
				$($i.find(".circle")[0]).css("background",  "url('img/circle50x50.png') -1px -1px no-repeat");
				$i.find("input[name='id']").attr("value", d.id);  //fix:wrong name - should be id
				if (editMode>0)
				{
					
					var editLink = "#"+tag+"?id="+d.id+"&mode=edit"; //fix:wrong link
					var newLink =  "#"+tag+"?mode=new"; //fix:wrong link
					$($i.find(".edit")[0]).attr("href",editLink);
					$($i.find(".new")[0]).attr("href",newLink);
					$i.find(".editbuttons .update").hide();
				
					$i.find(".editbuttons .cancel").hide();
					
					if (d.id>0)
					{	
						$i.find(".editbuttons .delete").click( function(e) { var id = ($(e.target).parent().find("input[name='id']").attr("value"));deleteItem(id); } ).show().css("cursor","hand").attr("href", "javascript:return false;"); 
					} else
					{
						$i.find(".editbuttons .delete").hide();
					}
					
						
				} else {
					
					$i.find(".editbuttons").hide();
				}
				
				if (data.length>1)
				{
					
					
					//postedISO8601 = '2013-03-11T15:24:17Z';		
					
					$($i.find(".link")[0]).text("READ MORE");//.attr("target", "_self");
					var detailedLink = "#"+tag+"?id="+d.id;
					$($i.find(".link")[0]).attr("href", detailedLink);
					
					
					
					
				} else
				{
	
					$($i.find(".counter")[0]).html(tag.toUpperCase());
					var detailedLink = "#"+tag;
					$($i.find(".link")[0]).text("Go back").attr("href", "#"+tag);;//.attr("target", "_blank");
					// Don't use individuals only main email - 
					// TODO: perhaps change this in the database and make default option
					//var detailedLink =  "mailto:"+(true ? "info@c-lab.co.uk" : d.contact_email)+"?subject=Apply to job '"+d.title+"' (ref: "+(d.reference)+")"; 
					$obj.find("h1:first-child").hide();
					$obj.find("#info").hide();
					document.title +=" | "+d.name.toUpperCase();
				}
				
				
				var startdate =new Date();
					if (d.startdate!=null && d.startdate>0) {
						startdate = new Date(d.startdate*1000);
					//	startdate.setUTCHours(startdate.getHours()+UTCOffset);
					} 
				//	alert((new Date(d.startdate*1000))+" "+d.name);
					var postedISO8601 = $.format.date(startdate, 'yyyy-MM-ddTHH:mm:ssZ');
					//alert(postedISO8601);
					$i.find(".circle .counter").html((i+1)+".");
					$i.find(".circle .counter").html($("<small/>").attr('title', postedISO8601 ).text(  $.format.date(startdate, 'd-MMM') ).prettyDate({interval: 10000}));
				
	
				//$($i.find(".place")[0]).html(d.region);
				$i.find("input[name='id']").attr("value", d.id);
				$($i.find(".description")[0]).html( d.body /* (data.length>1) ? Utils.summarise(d.body,300) : d.body*/ );
				var startdate =new Date();
				if (d.startdate!=null && d.startdate>0) {
						startdate = new Date(d.startdate*1000);
						startdate.setUTCHours(startdate.getHours()+UTCOffset);
				} 
				var enddate =new Date();
				if (d.enddate!=null && d.enddate>0) {
						enddate = new Date(d.enddate*1000);
						enddate.setUTCHours(enddate.getHours()+UTCOffset);
				} 
				
				if ($.format.date(enddate, 'HH:mm dd-MMM-yyyy')==$.format.date(startdate, 'HH:mm dd-MMM-yyyy') || enddate.getFullYear()<2000 || d.enddate == null)
				{
								$i.find(".date").html("Date: "+ $.format.date(startdate, 'HH:mm dd-MMM-yyyy'));
				} else if ($.format.date(enddate, 'dd-MMM-yyyy')==$.format.date(startdate, 'dd-MMM-yyyy')) {
					$i.find(".date").html("Date: "+ $.format.date(startdate, 'HH:mm') +"-"+ $.format.date(enddate, 'HH:mm dd-MMM-yyyy'));
				}else
				{
					$i.find(".date").html("Date: "+ $.format.date(startdate, 'HH:mm dd-MMM-yyyy') +"-"+ $.format.date(enddate, 'HH:mm dd-MMM-yyyy'));
				}
				enddate = $.format.date(startdate, 'HH:mm dd-MMM-yyyy'); 
				startdate = $.format.date(startdate, 'HH:mm dd-MMM-yyyy'); 
				
			
				var posted =new Date();
				if (d.posted!=null && d.posted>0) {
						posted = new Date(d.posted*1000);
						posted.setUTCHours(posted.getHours()+UTCOffset);
				} 
				
				posted = $.format.date(posted, 'HH:mm dd-MMM-yyyy'); 
				$i.find(".posted").html("Posted: "+ posted );
					
			//	$($i.find(".salary")[0]).html(d.salary);
				//$($i.find(".link")[0]).attr("href",detailedLink);
				$i.click( function(e) {
					//print_r($($(this).find(".link")));
				//	window.location = 	$($(this).find(".link")).attr("href");
				});
				//$i.hide();
				//$i.fadeOut(0);
				var speed = (1000*((i+1)/data.length));
				//$i.fadeIn(speed);
				$i.show();
				var k=2;
				if ($i.find(".circle .counter").text().length>11)
				{
					$i.find(".circle .counter").css("font-size", (14-k)+"px");
					k+=1;
				}
				var topY = ( 50-$i.find(".circle .counter").height() ) / 2;
				var leftX = ( 50-$i.find(".circle .counter").width() ) / 2;
				
				$i.find(".circle .counter").css("position", "relative").css("top", (topY)+"px").css("left", (leftX)+"px");
			
			}}
			
		
			if (data.length>1 && lastId>0)
			{
					
				for (var i=0;i<data.length;i++) {
					if (data[i]["id"]==lastId)
					{
						
						var $lastItem = $($obj.find(".item")[i+1]);
						
						//$.srollTo({ top: $($obj.find(".item")[i+1]).scrollTop() + 100 }
						
						if ($lastItem.size()>0)
						{
							$('html, body').animate({scrollTop: $lastItem.offset().top-$lastItem.height()}, 0);
						}
						//$('html, body').animate({scrollTop: $lastItem.offset().top-$lastItem.height()}, 500);
					}
				}
		
			//	$.scrollTo({ top: '+=100px', left: '+=0px' }, 800);
			}
			
			
			//alert('#'+$obj.attr("id")+' '+'.items')
			
			//$obj.find(".next-posts a").attr("href", "/to/"+(Number(page_to)+1));
		
			//	$obj.find(".next-posts a").attr("href", "list.php?method=all&tag="+tag+"&id="+id+"&count="+5+"&page_to="+page_to)
			
			
		//	alert(currScroll)
			$('html, body').animate( { scrollTop: currScroll}, 1 );
		
		
		/*
			show_more_previous(function () {
							paginate();
						});
			*/
			//alert('')
			
			
			
		} else {
		
			
			var $div = $("<div/>").hide().text("End of List").appendTo( $obj.find(".items") ).attr("id", "eol");
			$div.fadeIn(1000, function(){$(this).delay(2000).fadeOut(1000,function() { $(this).remove(); }) });
		}
		
		
	
		hide_loader();
		start_scroll();
	
		if (itemsBefore>0)
		{
	
				show_more_previous(itemsBefore, function () {
					paginate();
				});
		} else
		{
			var $div = $("<div/>").hide().text("Beginning of List").prependTo( $obj.find(".items") ).attr("id", "bol");
			$div.fadeIn(1000, function(){$(this).delay(2000).fadeOut(1000,function() { $(this).remove(); }) });
			hide_more_previous();
		}
		
		
	}
	function createDateAsUTC(date) {
    return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()));
    }
	var saveItems=function(data, i)
	{
		i=i==null? 0 : i+1
		
		if (i<data.length)
		{
			
			var d = data[i];
			if (d.id>0)
			{
				delete d.id;
			}
			saveItem(d,data,i);
			
		}
	}
	var deleteItem = function(id)
	{
		if (window.confirm("Are you sure you want to delete? "))
		{
			$.ajax({
						type: "POST",
						url: "list.php",
						dataType: 'json',
						data:{id: id, key: key, method: "delete"},
						success: function(response) { 
							if (response.result==1)
							{
								alert(response.message);
								
							} else 
							{
								alert(response.message);
							}
							
							var newLink = "#"+tag.toLowerCase()+"?refresh="+Math.random(); 
							window.location.hash = newLink;
							
									
						},
						failure: function(msg) {
							alert(msg);
						},
						error: function(msg) {
							alert(msg.responseText);
						}
			});
		}
		

	}
	var saveItem =function(job,data,i)
	{ 
		var $i= $obj.find(".items:last-child");
		if ($i.length==0)
		{
			 $i= $obj.find(".items .item");
		}
		$i.find(".circle .counter").text("wait");
		
		$.ajax({
					type: "POST",
					url: "list.php",
					dataType: 'json',
					data: job,
					success: function(response) {   
						
						
						
						if (Number(response.result)>0)
						{
						
							$i.find(".circle .counter").text($i.find(".circle .counter").attr("title"));
							alert(response.message);
							newLink = "#"+tag.toLowerCase()+"?id="+response.result+"&mode=view";//+(mode=="new" ? "view" : mode); 
							window.location.hash = newLink;
							
						}
					
					
						
						
					//	saveItems(data,i);				
					},
					failure: function(msg) {
						$i.find(".circle .counter").text("error");
						alert(msg);
					  
						//$('#output').text(msg);
					},
					error: function(msg) {
						$i.find(".circle .counter").text("error");
						alert(msg.responseText);
					  
						//$('#output').text(msg);
					}
		});
		
	}
	
	var print_r = function( x )
	{
		
		var str = "";
		for (var m in x)
			str += m+" "+x[m]+"\n";
		alert(str);
	}
	
	var updateAlert = function(s, addMore)
	{
		var extend = false;
		if (addMore)
			extend = true;
		if ($("#alertbox").length==0)
		{
			var box = $("<div/>").attr("id", "alertbox").css({width: "100%", height: "auto", top: "0px", left: "0px", "position":"absolute", "z-index" : "1000", "background-color": "rgba(60,40,50,.4)", "padding": "10px 10px 10px 10px", "white-space":"pre"});
			
			$("body").append( box );
			
		}
		
		$("#alertbox").text(!extend ||$("#alertbox").text().indexOf("Debug: ")  ? "Debug: "+s : "Debug: "+s+'\n'+ $("#alertbox").text().split("Debug: ")[1] ).css("top", ($(document).scrollTop())+"px");
	
	}
	
	

	
	init();
	$.fn.ListView.defaults = {   
		tag: null,
		pid: -1,
		id: -1,
		editMode: -1,
		mode: "view",
		key: ''
	} //end function
}
})(jQuery);