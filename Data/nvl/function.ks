;-------------------------------------------------------------------------------------------
;系統相關函數：鍵盤操作、選擇按鈕、自定界面宏、歷史記錄等
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------
;使用ALT+ENTER切換全屏/窗口
;------------------------------------------------------------
[iscript]
function changeScreenMode(key, shift)
{
  if (key != VK_RETURN || !(shift & ssAlt))
    return false;
  if (global.kag.fullScreen)
    global.kag.onWindowedMenuItemClick(global.kag);
  else
    global.kag.onFullScreenMenuItemClick(global.kag);
  return true;
}
// 押下時登錄
kag.keyDownHook.add(changeScreenMode);
[endscript]
;------------------------------------------------------------
;截圖功能
;------------------------------------------------------------
[iscript]
//保存截圖
function savenote(name)
{
	//設定保存路徑
	var fn = System.exePath + "/ScreenShot/" + name+".bmp";

	//鎖定當前截圖
	kag.tagHandlers.locksnapshot();
	//保存截圖
	kag.snapshotLayer.saveLayerImage(fn,"bmp32");
	//解鎖截圖
	kag.tagHandlers.unlocksnapshot();
	dm("保存截圖為"+name);
}

//獲得日期時間字符串
function getDateString()
{
	var time=new Date();
	
	var str=System.title;
	var year=time.getYear();
	var month=time.getMonth()+1;
	var day=time.getDate();
	
	if (month<10) month="0"+(string)month;
	if (day<10) day="0"+(string)day;
	
	var hour=time.getHours();
	var minute=time.getMinutes();
	var second=time.getSeconds();
	
	if (hour<10) hour="0"+(string)hour;
	if (minute<10) minute="0"+(string)minute;
	if (second<10) second="0"+(string)second;
	
	//最後結果
	str+=(string)year+(string)month+(string)day+"_";
	str+=(string)hour+(string)minute+(string)second;
	return str;
}

function ScreenShot(key, shift)
{	
  dm("按鍵編號"+key);
  
  //106為小鍵盤星號截圖鍵|116為F5
  if (!(key == 106 || key==116))
    return false;

	//保存圖片
	var str=getDateString();
	savenote("nvlmaker_"+str);
}
// 押下時登錄
kag.keyDownHook.add(ScreenShot);
[endscript]
;------------------------------------------------------------
;左鍵點擊顯示對話框
;------------------------------------------------------------
[iscript]
function onLeftClick()
{
  kag.process("rclick.ks", "*顯示對話框");
  return true;
}
[endscript]
;------------------------------------------------------------
;封裝的人物姓名宏，字體設置
;------------------------------------------------------------
[iscript]
//按照配置表的內容設定字體，默認只是改變字體顏色
function setfont()
{
  kag.tagHandlers.font(%["color"=>f.config_name[1].color]);
}
[endscript]
;------------------------------------------------------------
;字典相關數據處理
;------------------------------------------------------------
[iscript]
//刪除字典中的空值
function checkdict(name,value,dict)
{
	if (value=='') 
	{
		dict[name]=void;
	}
}

//將字典dict中不為空的值複製到字典param內
function setdictvalue(name,value,dict,param)
{
	if (value!=void)
	{
		param[name]=dict[name];
		//查看有幾個參數被傳入
		//dm("mp."+name+"="+value);
	}
}
[endscript]
;------------------------------------------------------------
;描繪選擇按鈕
;------------------------------------------------------------
[iscript]
//用函數創建按鈕並描繪文字
function createSelbutton(mp)
{
	var selbutton=%[];
	//複製默認設定
	(Dictionary.assign incontextof selbutton)(f.setting.selbutton);
	//將mp中傳入的值覆蓋默認設定
	foreach(mp,setdictvalue,selbutton);
	//刪除空值
	foreach(selbutton,checkdict);
	//根據字典建立按鈕
	kag.tagHandlers.button(selbutton);

	//為描繪文字做出處理

	//假如沒有填寫劇本，則讀取當前執行中的劇本名
	if (mp.storage==void) mp.storage=Storages.extractStorageName(kag.conductor.curStorage);
	//假如連標籤也沒有，就自動填個標籤
	if (mp.target==void) mp.target="*start";

	//在按鈕上描繪文字
	drawSelButton(mp.text,mp.storage,mp.target);
}

//描繪按鈕文字用函數
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默認文字樣式設定
	button.font.face = kag.fore.messages[0].userFace;
	button.font.bold = kag.fore.messages[0].defaultBold;
	button.font.height = f.setting.selfont.height;
	
	//sel顏色設定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

	var w = button.font.getTextWidth(caption); // 取得要描繪文字的寬度
	var x = (button.width - w) \ 2;    // 在按鈕中央顯示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按鈕上的y位置（左上角起算）

	//取得既讀設定
	var target_name=target.substring(1,target.length-1); //去掉星號
	var labelname="trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var checklabel="sf[\""+labelname+"\"]";
	var sel_color;

	// 既讀文字顏色設定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	//設定每行最大字數
	var num=20;
	//計算行數
	var t_linecount=caption.length\num;
	if  (caption.length%num>0) {t_linecount++;}
	//假如多於1行，修改x的坐標
	if (t_linecount>1) x=(button.width - button.font.getTextWidth("一")*num) \ 2;

	//描繪文字
	for (var i=0; i<t_linecount; i++)
	{
		//y的坐標隨行數變化
		var y=(button.height - button.font.getTextHeight(caption)*t_linecount) \ 2+i*button.font.getTextHeight(caption);
		//以20個字為單位取得要描繪的文字
		var text=caption.substring(i*num,num);

		if (kag.fore.messages[0].defaultEdge) //默認設置帶有描邊
		{
			// 按鈕「通常狀態」部分文字顯示
			button.drawText(x,y, text, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
			// 按鈕「按下狀態」部分文字顯示
			button.drawText(x+button.width, y, text, on ,255, true, 255, edgecolor, 1, 0, 0);
			// 按鈕「選中狀態」部分文字顯示
			button.drawText(x+button.width+button.width, y, text, over ,255, true, 255, edgecolor, 1, 0, 0);
		}
		else if (kag.fore.messages[0].defaultShadow)//默認設置帶有陰影
		{
			// 按鈕「通常狀態」部分文字顯示
			button.drawText(x,y, text, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
			// 按鈕「按下狀態」部分文字顯示
			button.drawText(x+button.width, y, text, on ,255, true, 255, shadowcolor, 0, 2, 2);
			// 按鈕「選中狀態」部分文字顯示
			button.drawText(x+button.width+button.width, y, text, over ,255, true, 255, shadowcolor, 0, 2, 2);
		}
		else //無任何效果
		{
			// 按鈕「通常狀態」部分文字顯示
			button.drawText(x,y, text, sel_color, 255, true);
			// 按鈕「按下狀態」部分文字顯示
			button.drawText(x+button.width, y, text, on ,255, true);
			// 按鈕「選中狀態」部分文字顯示
			button.drawText(x+button.width+button.width, y, text, over ,255, true);
		}

	}

}
[endscript]
;------------------------------------------------------------------
;自定按鈕宏（對應NVL參數字典,標籤，表達式，TICK間隔時間，點擊時每TICK執行函數）
;------------------------------------------------------------------
[iscript]

function mybutton(dicname,target,exp,interval,ontimer)
{
	//新建字典並複製一份參數
	var mybutton=new Dictionary(); 
	mybutton=dicname!;

	//假如內容為空，則不發生任何事
	if (mybutton==void) return;
	
	//假如按鈕存在並且使用到，則增加其他傳入參數
	if (mybutton.use==true)
	{
		kag.tagHandlers.locate(
		%[
			"x" => mybutton.x,
			"y" => mybutton.y
		]);

		mybutton.target=target;
		mybutton.exp=exp;
		
		mybutton.interval=interval;
		mybutton.ontimer=ontimer;

		//刪除字典內的空值
		foreach(mybutton,checkdict);
		kag.tagHandlers.button(mybutton);

	}
}
[endscript]
;------------------------------------------------------------------
;系統按鈕有效、無效操作
;------------------------------------------------------------------
[iscript]
//無效化單個系統按鈕（foreach循環用）
function oneButtonEnabled(name,value,dict,enabled)
{
	dict[name].enabled=enabled;
}
//將所有系統按鈕無效化/有效化的函數
function setSysbuttonEnabled(page,enabled)
{
	var layer;
	
	if (page=="fore") layer=kag.fore.messages[2];
	else layer=kag.back.messages[2];

	//if (layer.buttons[name]!=void) layer.buttons[name].enabled=enabled;//處理單個按鈕的範例

	//批量處理當前層上所有按鈕
	foreach(layer.buttons,oneButtonEnabled,enabled);
}
[endscript]
;------------------------------------------------------------------
;自定系統按鈕宏（系統按鈕名字，對應NVL參數字典，表達式，不安定時是否可點）
;------------------------------------------------------------------
[iscript]
function mysysbutton(dicname,name,exp,nostable)
{

	var mysysbutton=new Dictionary();
	mysysbutton=dicname!;
	
	//假如不存在對應的參數，則不發生任何事
	if (mysysbutton==void) return;

	//假如按鈕存在並且使用到，則增加其他傳入參數
	if (mysysbutton.use==true)
	{
		mysysbutton.name=name;
		mysysbutton.exp=exp;
		mysysbutton.nostable=nostable;

		//刪除字典內的空值
		foreach(mysysbutton,checkdict);

		kag.tagHandlers.sysbutton(mysysbutton);

	}
}
[endscript]
;------------------------------------------------------------
;自定滑動槽
;------------------------------------------------------------
[iscript]
//即時調整音效和語音音量的函數
function setSeVolume()
{
    kag.se[0].volume=sf.sevolume;
	dm("Se Volume="+kag.se[0].volume);
}

function setVoiceVolume()
{
	kag.se[1].volume=sf.voicevolume;
	dm("Voice Volume="+kag.se[1].volume);
}
[endscript]

[iscript]
//滑動槽定義
function myslider(dicname,value,max,min,mychangefunc)
{

	var myslider=new Dictionary();	
	myslider=dicname!;

	//假如不存在對應的參數，則不發生任何事
	if (myslider==void) return;

	//假如Slider存在並且使用到，則增加其他傳入參數
	if (myslider.use==true)
	{

		kag.tagHandlers.locate(
		%[
			"x" => myslider.x,
			"y" => myslider.y
		]);

		myslider.nofixpos=true;
		myslider.nohilight=true;

		myslider.value=value;
		myslider.max=max;
		myslider.min=min;

		myslider.mychangefunc=mychangefunc;

		//刪除字典內的空值
		foreach(myslider,checkdict);
		//創建滑動槽
		kag.tagHandlers.slider(myslider);

	}
}
[endscript]
;------------------------------------------------------------
;歷史記錄裡，播放語音用的函數
;------------------------------------------------------------
[iscript]
//簡單的播放語音函數
function playse(file,buf=1,isloop=false)
{
	kag.tagHandlers.playse(%[
	"storage"=>file,
	"buf"=>buf,
	"loop"=>isloop
	]);
}
[endscript]
;------------------------------------------------------------
;歷史記錄裡，識別人名並自動返回對應顏色
;------------------------------------------------------------
[iscript]
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
	         var name=text.substring(1,text.length-2);
	         var arr=f.config_name;
         
	         //為主角，使用主角的顏色
	         if (name==f.姓+f.名) return arr[0].color;
	         //否則
	         //是姓名列表裡的角色，使用列表裡設置的顏色
	           for (var i=2;i<arr.count;i++)
	          {
	             if (arr[i].name==name) return arr[i].color;
	           }
           
	         //無顏色記錄,使用路人的顏色
	         return arr[1].color;

       }
       //不是人名，返回對話默認字體顏色
       return kag.fore.messages[0].defaultChColor;
}
[endscript]
;------------------------------------------------------------
;為ptext指令增加\n換行效果
;------------------------------------------------------------
[iscript]
kag.tagHandlers.ptext = function(elm)
{
        var layer = getLayerFromElm(elm);

        if(elm.lineheight === void)
        {
                layer.drawReconstructibleText(elm);
        }
        else
        {
                var textS = elm.text;
                var textarr = textS.split(/\\n|\n/);
                var lineheight = +elm.lineheight;
                var iy = +elm.y;
                for(var i=0; i<textarr.count; i++)
                {
                        elm.text = textarr[i];
                        layer.drawReconstructibleText(elm);
                        iy += lineheight;
                        elm.y = iy;
                }
        }
        return 0;
} incontextof kag;
[endscript]
;------------------------------------------------------------
[return]
