;-------------------------------------------------------------------------------------------
;系統按鈕、標題畫面、OPTION畫面及其他零碎用的宏
;對應函數在function.ks裡
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------------
;系統全屏框宏，用於設置一個等於遊戲畫面大小的全透明消息層
;過去是用empty這張圖片來代替的，現在改掉了
;------------------------------------------------------------------
[macro name="frame"]
	[position frame="" layer="%layer|message0" page="%page|fore" visible="%visible|true" marginb=0 marginl=0 marginr=0 margint=0 color="0xFFFFFF" opacity="0" width=&"kag.scWidth" height=&"kag.scHeight" left="0" top="0"]
[endmacro]
;------------------------------------------------------------------
;自定界面按鈕
;------------------------------------------------------------------
[macro name=mybutton]
	[eval exp="mybutton(mp.dicname,mp.target,mp.exp,mp.interval,mp.ontimer)"]
[endmacro]
;------------------------------------------------------------------
;系統按鈕
;------------------------------------------------------------------
;系統按鈕單個定義
[macro name=mysysbutton]
	[eval exp="mysysbutton(mp.dicname,mp.name,mp.exp,mp.nostable=0)"]
[endmacro]

;系統按鈕全部定義
[macro name=defsysbutton]

	[frame layer="message2" visible="false"]
	[current layer="message2" page="fore"]

	[csysbutton]

	[mysysbutton name="save" dicname="f.config_dia.save" exp="kag.callExtraConductor('save.ks', '*start')"]
	[mysysbutton name="load" dicname="f.config_dia.load" exp="kag.callExtraConductor('load.ks', '*start')"]

	[mysysbutton name="skip" dicname="f.config_dia.skip" exp="kag.onSkipToNextStopMenuItemClick()" nostable=true]
	[mysysbutton name="auto" dicname="f.config_dia.auto" exp="kag.onAutoModeMenuItemClick()" nostable=true]

	[mysysbutton name="hide" dicname="f.config_dia.hide" exp="kag.onRightClickMenuItemClick() if (System.getTickCount()-tf.clicked>150)"]
	[mysysbutton name="history" dicname="f.config_dia.history" exp="kag.onShowHistoryMenuItemClick()"]

	[mysysbutton name="option" dicname="f.config_dia.option" exp="kag.callExtraConductor('option.ks', '*start')"]
	;修改功能
	[mysysbutton name="menu" dicname="f.config_dia.menu" exp="kag.goToStartWithAsk()"]
	;修改功能
	[mysysbutton name="other" dicname="f.config_dia.other" exp="kag.close()"]

	;想要自己追加系統按鈕，可以這樣：
	;[sysbutton name="按鈕名" normal="一般圖片" over="選中圖片" on="按下圖片" x=100 y=100 exp="kag.callExtraConductor('文件名.ks', '*標籤名')"]

[endmacro]

;系統按鈕無效化
[macro name=disablesysbutton]
	[eval exp="setSysbuttonEnabled(mp.page,0)"]
[endmacro]

;系統按鈕有效化
[macro name=enablesysbutton]
	[eval exp="setSysbuttonEnabled(mp.page,1)"]
[endmacro]

;顯示系統按鈕
[macro name=showsysbutton]
	[layopt layer=message2 page=%page|back visible=true]
[endmacro]

;隱藏系統按鈕
[macro name=hidesysbutton]
	[layopt layer=message2 page=%page|back visible=false]
[endmacro]

;------------------------------------------------------------------
;標題畫面按鈕
;------------------------------------------------------------------
[macro name=button_title]

	[mybutton dicname="f.config_title.start" target=*開始遊戲]
	[mybutton dicname="f.config_title.load" target=*讀取進度]

	[mybutton dicname="f.config_title.option" target=*系統設定]

	[mybutton dicname="f.config_title.exit" target=*離開遊戲]

	[mybutton dicname="f.config_title.omake" target=*CG模式]
	[mybutton dicname="f.config_title.extra" target=*自定選單]

	;想要自己追加標題按鈕，可以這樣：
	;[locate x=100 y=100]
	;[button normal="一般圖片" over="選中圖片" on="按下圖片" target="*標籤名"]

[endmacro]
;------------------------------------------------------------------
;主選單按鈕
;------------------------------------------------------------------
[macro name=button_menu]

	[mybutton dicname="f.config_menu.save" target=*保存遊戲]
	[mybutton dicname="f.config_menu.load" target=*讀取進度]

	[mybutton dicname="f.config_menu.option" target=*系統設定]
	[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]

	[mybutton dicname="f.config_menu.other" target=*自定選單]

	[mybutton dicname="f.config_menu.exit" exp="kag.close()"]
	[mybutton dicname="f.config_menu.totitle" exp="kag.goToStartWithAsk()"]
	[mybutton dicname="f.config_menu.back" target=*返回]

	;想要自己追加主選單按鈕，可以這樣：
	;[locate x=100 y=100]
	;[button normal="一般圖片" over="選中圖片" on="按下圖片" target="*標籤名"]

[endmacro]
;------------------------------------------------------------
;系統設定
;------------------------------------------------------------
;簡化滑動槽宏
[macro name=myslider]
	[eval exp="myslider(mp.dicname,mp.value,mp.max,mp.min,mp.mychangefunc)"]
[endmacro]

[macro name=button_option]
	;----------------------滾動條----------------------
	;文字速度
	[myslider value="kag.textspeed" dicname="f.config_option.textspeed" max=10 min=0]
	;自動前進速度
	[myslider value="kag.autospeed" dicname="f.config_option.autospeed" max=10 min=0]
	;音樂音量
	[myslider value="kag.bgmvolume" dicname="f.config_option.bgmvolume" max=100 min=0]
	;音效音量
	[myslider mychangefunc="setSeVolume" value="sf.sevolume" dicname="f.config_option.sevolume" max=100 min=0]
	;語音音量
	[myslider mychangefunc="setVoiceVolume" value="sf.voicevolume" dicname="f.config_option.cvvolume" max=100 min=0]
	;----------------------checkbox----------------------
	;畫面模式
	[mybutton dicname="f.config_option.fullscreen" target=*刷新畫面 exp="kag.onFullScreenMenuItemClick()" cond="kag.fullScreen==false"]
	[mybutton dicname="f.config_option.window" target=*刷新畫面 exp="kag.onWindowedMenuItemClick()" cond="kag.fullScreen==true"]
	;略過模式
	[mybutton dicname="f.config_option.allskip" target=*刷新畫面 exp="kag.allskip=true" cond="kag.allskip==false"]
	[mybutton dicname="f.config_option.readskip" target=*刷新畫面 exp="kag.allskip=false" cond="kag.allskip==true"]
	;----------------------按鈕----------------------
	;返回標題
	[mybutton dicname="f.config_option.totitle" exp="kag.goToStartWithAsk()"]
	;關閉遊戲
	[mybutton dicname="f.config_option.endgame" exp="kag.close()"]
	;返回按鈕
	[mybutton dicname="f.config_option.back" target=*返回]
	;恢復默認
	[mybutton dicname="f.config_option.reset" target=*默認]
	;----------------------補充描繪當前高亮狀態----------------------
	[image layer=15 page=%page storage=empty visible=true left="0" top="0"]
	[if exp="(f.config_option.fullscreen.use==true) && kag.fullScreen==true"]
	[pimage layer=15 page=%page storage=&"f.config_option.fullscreen.over" dx=&"f.config_option.fullscreen.x" dy=&"f.config_option.fullscreen.y"]
	[endif]
	[if exp="(f.config_option.window.use==true) && kag.fullScreen==false"]
	[pimage layer=15 page=%page storage=&"f.config_option.window.over" dx=&"f.config_option.window.x" dy=&"f.config_option.window.y"]
	[endif]
	[if exp="(f.config_option.allskip.use==true) && kag.allskip==true"]
	[pimage layer=15 page=%page storage=&"f.config_option.allskip.over" dx=&"f.config_option.allskip.x" dy=&"f.config_option.allskip.y"]
	[endif]
	[if exp="(f.config_option.readskip.use==true) && kag.allskip==false"]
	[pimage layer=15 page=%page storage=&"f.config_option.readskip.over" dx=&"f.config_option.readskip.x" dy=&"f.config_option.readskip.y"]
	[endif]
	[endmacro]
;------------------------------------------------------------
[return]
