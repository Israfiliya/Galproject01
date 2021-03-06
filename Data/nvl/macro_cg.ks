;-------------------------------------------------------------------------------------------
;CG設定相關宏
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;取得CG縮略圖列表
;-------------------------------------------------------------------------------------------
[iscript]
function getThumList()
{

	var list=[].load(f.cginfo);

	var thumlist=[];

	for (var i=0;i<list.count;i++)
	{
		var obj=list[i];
		var arr=obj.split(",");
		thumlist.add(arr[0]);
	}

	return thumlist;
}

[endscript]
;-------------------------------------------------------------------------------------------
;取得已登錄的CG差分
;-------------------------------------------------------------------------------------------
[iscript]
function getCgDif(num)
{

	var list=[].load(f.cginfo);
	var obj=list[num];
	var arr=obj.split(",");

	var cglist=[];

	dm(" 列表文件"+f.cginfo+"，第"+num+"行，共"+arr.count+"個差分");

	for (var i=0;i<arr.count;i++)
	{
		var name=arr[i];

		//只有已經登錄的CG才會被顯示
		if (sf.cglist[name]==true)
		{
			cglist.add(name);
			dm(" 差分"+name+"已登陸");
		}
		else
		{
			dm(" 差分"+name+"未登陸");
		}
	}

	return cglist;
}

[endscript]

;-------------------------------------------------------------------------------------------
;登錄CG
;-------------------------------------------------------------------------------------------
[iscript]
function AddToCgList(name)
{
	//假如是第一次登錄CG
	if (sf.cglist==void) sf.cglist=%[];
	sf.cglist[name]=true;
	dm("登錄CG："+name);
}
[endscript]

[macro name=addcg]
[eval exp="AddToCgList(mp.storage)"]
[endmacro]
;-------------------------------------------------------------------------------------------
;CG按鈕【取得縮略圖的文件名，以及在對應列表文件裡的行號】
;-------------------------------------------------------------------------------------------
[iscript]
function CgButton(name,num)
{

		f.config_cgmode.thum.target="*顯示CG";

		//點下按鈕之後執行的表達式，將通過行號取得同一縮略圖的差分列表並準備顯示
		f.config_cgmode.thum.exp="(tf.CG差分=getCgDif("+num+")),(tf.CG編號=0)";

		//利用thumbnail大小圖片添加一個CG按鈕
		kag.current.addButton(f.config_cgmode.thum);

		//設定按鈕為最近添加的按鈕
		var button=kag.current.links[kag.current.links.count-1].object;

        //臨時圖層，讀取CG或CG縮略圖
        var temp=new Layer(kag, kag.fore.base);

		//查找PNG格式的縮略圖，找不到則直接縮放原圖
		if (Storages.isExistentStorage(name+"_thum"+".png"))
		{
			temp.loadImages(name+"_thum");
		}
        else
		{
			temp.loadImages(name);
		}

        temp.setSizeToImageSize();

        //臨時圖層，讀取thumbnail大小圖片
        var temp2=new Layer(kag, kag.fore.base);
        temp2.loadImages(f.config_cgmode.thum.normal);
        temp2.setSizeToImageSize();

		//將CG縮略圖描繪到按鈕上
        button.stretchCopy(0, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width*2, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        
        //選中效果（thumbnail大小圖片同時作為高亮效果使用）
         button.operateStretch(button.width, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height);
         button.operateStretch(button.width*2, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height);
        
}
[endscript]

;-------------------------------------------------------------------------------------------
;CG列表
;-------------------------------------------------------------------------------------------
[iscript]
function draw_cglist()
{

	dm("=========描繪CG按鈕，當前第"+tf.當前CG頁+"頁=========");

	for (var i=0;i<f.config_cgmode.locate.count;i++)
	{	     
	     kag.tagHandlers.locate(%["x"=>f.config_cgmode.locate[i][0],"y"=>f.config_cgmode.locate[i][1]]);
	     
	     //取得CG在列表中的編號（行號）
	     var j=i+f.config_cgmode.locate.count*(tf.當前CG頁-1);
	     
	     if (f.cglist[j]!=void)
	     {
		    var name=f.cglist[j];
		    
		    if (sf.cglist[name]==true)
		    {
			    dm("【CG按鈕："+name+"成功顯示】");
				//假如已經登陸了這張CG文件，則顯示按鈕
			    CgButton(name,j);
		    }
		    else
		    {
			    dm("【CG按鈕："+name+"尚未登錄】");
		    }
	     }
	}
}
[endscript]

[macro name=draw_cglist]

	;描繪CG
	[eval exp="draw_cglist()"]
	
	;前一頁
	[mybutton dicname="f.config_cgmode.up" exp="tf.當前CG頁-- if (tf.當前CG頁>1)" target=*刷新畫面]
	;後一頁
	[mybutton dicname="f.config_cgmode.down" exp="tf.當前CG頁++ if (tf.當前CG頁<tf.CG頁數)" target=*刷新畫面]
	;返回按鈕
	[mybutton dicname="f.config_cgmode.back" target=*返回]

[endmacro]
;-------------------------------------------------------------------------------------------
[return]

