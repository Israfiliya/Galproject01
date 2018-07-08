;------------------------------------------------------------
;點下「開始遊戲」以後一開始默認執行的內容
;你可以把下面替換成自己的劇本，或者直接從這裡跳躍到其他自建腳本
;------------------------------------------------------------
*start|序章
@scr
@history output="true"
@deffont size="30" face="Adobe 繁黑體 Std B" color="0xffffff"
@defstyle linespacing="10" linesize="4" pitch="0"
@w
昏暗潮濕的密林里，微微的呼吸聲在樹木之間迴蕩。[lr]
@r
“哈——”[lr]
@r
“哈……哈……”[lr]
@r
褐色頭髮的青年小口而急促地呼吸著空氣，不想發出過多的聲音，只為了能讓狂跳的心臟得到些許的平靜。
@bg storage="mountain001_cloud"
@l
他躲在了一塊大岩石的後面，拼命調整呼吸，想讓自己冷靜下來。[l]
雖然雙腳已經因為長距離的不斷奔跑失去了知覺，但是手中突擊步槍握柄的冰冷觸感倒是十分清晰。[w]
“必須趕快移動，那群長耳朵的索敵魔法可不是蓋的……”[lr]
@r
短短不到30秒的休息，再次環視周圍情況后，青年就驅使著自己勞累不堪的雙腿，再次穿梭在了樹木的迷宮裡面。[l]只要能夠逃出這片密林，就有希望，或許能看到接應自己的同伴，青年默默的激勵著自己，相信自己一定能獲救。[l]同時，也在為自己的莽撞決定所帶來的後果而後悔。[w]
@clbg hidemes=1
@scr
已經死了5個人了，從小一起同甘共苦的兄弟姐妹就這樣死了。[lr]
[r]
Allen，那個經常和自己鬥嘴，比誰更高，一直都覺得高高在上的蠢蛋。
連呼喊的機會都沒有，就被巨石像的拳頭給砸成了肉泥……[lr]

@nvl娘 face="face01_01" fg="fg01_01"
對於一些作品的二次創作（即是俗稱的XX作品的同人），在沒有獲得官方授權的情況下，也不可以使用官方的原畫、截圖、OST等。[w]
@nvl娘 face="face01_02" fg="fg01_02"
真心想要製作二次創作遊戲的話，請寫信去向官方索要授權，[lr]或者徵集同好一起來畫圖、創作音樂吧。[w]
@nvl娘 face="face01_01" fg="fg01_01"
接下來進入演示正題～[w]
@clfg layer="8" time="100"
;----------
;設置默認姓名
@eval exp="f.姓='abc'"
@eval exp="f.名='def'"
@history output="false"
;自定義主角名字的代碼
@nowait
請輸入主角名字：[r]
姓氏：[edit opacity=0 color=0xFFFFFF name=f.姓][r]
名字：[edit opacity=0 color=0xFFFFFF name=f.名][r]
@links target="*輸入完畢" text="確定" hint="點這裡繼續~"
@endnowait
@history output="true"
@s
;----------
*輸入完畢
;將輸入的名字使用commit保存下來，沒有這個指令的話輸入了也還是維持默認值
@commit
@er
;使用emb指令來在對話裡顯示變數的值
@主角
主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@fg layer="0" pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
那麼，測試一下選擇吧。[w]
@clfg layer="0" clface="1"
;----------
;顯示選擇按鈕
@selstart hidemes="0" hidesysbutton="0"
@locate y="200" x="0"
@selbutton target="*選擇A" text="我要選擇A"
@locate y="300" x="0"
@selbutton target="*選擇B" text="我要選擇B"
@selend
;----------
*選擇A|路線一
@clsel
@bg storage="cg_01"
;登陸CG（記得也要在cglist.txt裡寫上對應CG名才能成功顯示）
@addcg storage="cg_01"
@npc id="路人甲"
你選擇了A。第一張CG現在可以在CG模式裡查看了。[w]
@bg storage="cg_01_a"
@addcg storage="cg_01_a"
@npc id="路人甲"
第一張CG的變化也被登陸了，現在在CG模式中點選第一張CG，會連續顯示兩張圖。[w]
@jump target="*合併"
;----------
*選擇B|路線二
@clsel
@bg storage="cg_02"
;登陸CG（記得也要在cglist.txt裡寫上對應CG名才能成功顯示）
@addcg storage="cg_02"
@npc id="路人甲"
你選擇了B。第二張CG現在可以在CG模式裡查看了。[w]
@jump target="*合併"
;----------
*合併
@npc id="路人甲"
不管選擇了A還是B，最後你都會看到這句話。[w]
@scr
試試另外一個樣式的對話框……[w]
你也可以切換文字的顏色。[l][font color=0xCCFFCC]比如這樣……[resetfont][lr][r]
改變[font size=30]大[font size=15]小[resetfont]也沒有問題喲。[w]
@dia
@npc id="路人甲"
現在換回來了……[w]
@npc id="路人甲"
地圖測試。[w]
@clfg layer="all"
@map storage="sample.map"
;----------
*地圖01|教室
@clmap
@bg storage="BG01a"
@dia
@主角
來到了教室。[w]
@call storage="endA.ks"
;呼叫結局事件A，當事件執行完之後就會返回這裡
@jump target="*地圖合併"
;----------
*地圖02|車上
@clmap
@bg storage="BG12a"
@dia
@主角
來到了車上。[w]
@call storage="endB.ks"
;呼叫結局事件B，當事件執行完之後就會返回這裡
@jump target="*地圖合併"
;----------
*地圖合併
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
功能演示完畢。[lr]
更多內容請查看tutorial文件夾下的教程。[w]
@nvl娘 face="face01_01" fg="fg01_01"
準備好就返回標題了哦。[w]
;執行返回標題指令，返回到標題畫面
@gotostart ask="false"
