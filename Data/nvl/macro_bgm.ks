;-------------------------------------------------------------------------------------------
;音樂鑒賞界面相關函數
;-------------------------------------------------------------------------------------------
[iscript]
function BgmButton(name)
{
	//取得顯示名和播放文件名
	var text=name.split(',');
	
	//按鈕設定
	var dic=%[];
	
	var list=f.config_bgmmode.list;

	dic.normal=list.normal; //這裡是設定BGM按鈕底圖的地方
	dic.over=list.over;
	dic.on=list.on;

	if (text[1]==kag.bgm.playingStorage)
	{
		dic.normal=list.over;
	}
	
	dic.exp="tf.當前BGM=\""+text[1]+"\"";
	dic.target="*播放音樂";
	kag.current.addButton(dic);
	
	//在按鈕上描繪文字

	var x=(int)list.x;//設定按鈕上文字位置的地方
	var y=(int)list.y;
	
	var str=text[0];
	var button=kag.current.links[kag.current.links.count-1].object;
	
	button.font.height=list.size;//設定字體大小
	button.font.italic=list.italic;//是否斜體
	button.font.bold=list.bold;//是否粗體
	
	if (list.edge)
	{
		button.drawText(x,y, str, list.color, 255, true, 255, list.edgecolor, 1, 0, 0);
		button.drawText(x+button.width,y, str, list.color, 255, true, 255, list.edgecolor, 1, 0, 0);
		button.drawText(x+button.width*2,y, str, list.color, 255, true, 255, list.edgecolor, 1, 0, 0);
	}
	else if (list.shadow)
	{
		button.drawText(x,y, str, list.color, 255, true, 255, list.shadowcolor, 0, 2, 2);
		button.drawText(x+button.width,y, str, list.color, 255, true, 255, list.shadowcolor, 0, 2, 2);
		button.drawText(x+button.width*2,y, str, list.color, 255, true, 255, list.shadowcolor, 0, 2, 2);
	}
	else
	{
		button.drawText(x,y,str,list.color);
		button.drawText(x+button.width,y,str,list.color);
		button.drawText(x+button.width*2,y,str,list.color);
	}
}
function draw_bgmlist()
{

	//簡寫名稱
	var list=f.config_bgmmode.list;

	//載入按鈕圖片確定大小
    var temp=new Layer(kag, kag.fore.base);
	temp.loadImages(list.normal);
	temp.setSizeToImageSize();

	var width=temp.width;
	var height=temp.height;
	
	for (var i=0;i<list.num;i++)
	{
		if ((tf.當前BGM頁-1)*list.num+i>=f.bgmlist.count) break;
		
		if (list.line=="single")
		{
			var btnx=list.left;
			var btny=list.top+(height+(int)list.disy)*i;
			kag.tagHandlers.locate(%["x"=>btnx,"y"=>btny]);
		}
		else
		{
			var btnx=list.left+(width+(int)list.disx)*(i%2);
			var btny=list.top+(height+(int)list.disy)*(int)(i/2);
			kag.tagHandlers.locate(%["x"=>btnx,"y"=>btny]);
		}

		BgmButton(f.bgmlist[(tf.當前BGM頁-1)*list.num+i]);
	}
}
[endscript]
;-------------------------------------------------------------------------------------------
;描繪bgm按鈕
;-------------------------------------------------------------------------------------------
[macro name=draw_bgmlist]

	;BGM按鈕
	[eval exp="draw_bgmlist()"]
	
	;上翻按鈕
	[mybutton dicname="f.config_bgmmode.up" target=*刷新畫面 exp="tf.當前BGM頁-- if (tf.當前BGM頁>1)" cond="tf.BGM頁數>1"]
	;下翻按鈕
	[mybutton dicname="f.config_bgmmode.down" target=*刷新畫面  exp="tf.當前BGM頁++ if (tf.當前BGM頁<tf.BGM頁數)" cond="tf.BGM頁數>1"]
	;返回按鈕
	[mybutton dicname="f.config_bgmmode.back" target=*返回]

[endmacro]

;-------------------------------------------------------------------------------------------
[return]
