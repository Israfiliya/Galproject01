;------------------------------------------------------------
;點下「開始遊戲」以後一開始默認執行的內容
;你可以把下面替換成自己的劇本，或者直接從這裡跳躍到其他自建腳本
;------------------------------------------------------------
*start|序章
@scr
@history output="true"
@deffont size="30" edgecolor="ffffffff" face="Adobe 繁黑體 Std B" color="0xFFFFFF" edge="true"
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
短短不到30秒的休息，再次環視周圍情況后，青年就驅使著自己勞累不堪的雙腿，再次穿梭在了樹木的迷宮裡面。[l]
@quake time="7000" vmax="20" hmax="20"
@bg time="1000" method="crossfade" storage="mountain004_cloud"
只要能夠逃出這片密林，就有希望，或許能看到接應自己的同伴，青年默默的激勵著自己，相信自己一定能獲救。[l]同時，也在為自己的莽撞決定所帶來的後果而後悔。[w]
@clbg hidemes="1"
@scr
已經死了5個人了，從小一起同甘共苦的兄弟姐妹就這樣死了。[lr]
@r
Allen，那個經常和自己鬥嘴，比誰更高，一直都覺得高高在上的蠢蛋。
@bg storage="blood01"
連呼喊的機會都沒有，就被巨石像的拳頭給砸成了肉泥……[lr]
@clbg hidemes="1"
@scr
@r
@r
@r
Thomas，那個連魚都不敢殺的膽小鬼，聽到Callie被抓走之後第一個和自己請求一起營救的的傻小子。
@bg storage="blood03"
一槍未發，就被閃電劈成了焦炭……[lr]
@clbg hidemes="1"
@scr
@r
@r
@r
Caw，一直溫柔關懷著每個隊友的大哥哥，在一次遭遇戰中為了保護別人推開了無法動彈的自己，隨後被銳利的風刃切成碎塊。
@bg storage="blood04"
到現在還能記得那在風中飄散的血珠以及肉沫.....[lr]
@clbg hidemes="1"
@scr
@r
@r
@r
負責通信支援的Ciel，30分鐘前就斷了聯繫，肯定是被那群長耳朵的雜種發現了，
@bg storage="blood06"
直到通信器斷線的之前自己都能聽到Ciel那哭喊求饒的聲音……[w]
@clbg hidemes="1"
@scr
…………[lr]
@r
“Lucius，真希望大家能一起幸福的生活下去呢~”[lr]
@r
@bg storage="mountain004_cloud"
腦中迴蕩著自己的搭檔兼好友對自己說的美好願望，Lucius回想起了這糟糕的一天。[lr]
@r
自己和和隊友們一起搜索資源，Callie因為参加了之前的任务，所以留下來休息。[l]然而回來時村子已经被洗劫一空，Callie也沒了下落，可能被那群長耳朵的掠走了……[w]
或許Callie還算好的，[l]鄰家的Phya被發現的時候已經沒有了四肢，舌頭被割掉，身上沾滿了那群雜種的精液。[l]
之后自己帶領著最精銳的人去密林偷襲敵人的營地，希望藉此找到Callie，可是中了埋伏，隊員一個個的慘死……[w]
名為Lucius的褐髮青年也不斷的反問自己：為什麼，自己會落到這副下場？[w]
@clbg hidemes="1"
@scr
理由很簡單，選錯了對手，這個星球早就不是人類君臨一切了。[lr]
@r
@bg storage="war"
一百年前，資源匱乏的人類向隱居在這個星球的精靈發出了請求。[l]與自然和諧共存是精靈的生存之道，他們靠著魔法，充分發揮著每一顆樹每一滴水的價值。[l]
於是人類就向精靈求助，以領土為代價，換取能讓資源再生的魔法。[w]
或許人類生性狡猾，這種合作並沒有持續多久，很快雙方就爆發了戰爭，剛開始時勝利的天平似乎傾向人類，畢竟箭矢快不過子彈，火焰魔法燒不穿戰車的裝甲。[l]
然而輕敵的人類小看了自然的力量，防禦再厚的戰車也逃不過大地震，速度再快的戰鬥機也躲不過閃電風暴。[l]
當精靈們不再射出弓箭，而是創作出巨大魔法陣操使自然掀風推海的時候，人類的戰敗就成了定局。[w]
@clbg hidemes="1"
@scr
或許戰敗者就要有戰敗著該有的樣子，在戰爭中倖存下來的人類的出路就只有兩條：
要麼被奴役，要不就像Lucius他們一樣，不斷逃亡，支離破碎。[l]
附加近10年來規模越來越龐大的人類狩獵，像Lucius這樣還擁有自由，敢於反抗的人類已經越來越少了。[w]
@bg storage="mountain004_cloud"
Lucius搖了搖頭，再次握緊了手中的槍，此時不需要回憶那些只存在于老人口中的歷史，[l]
只需要奔跑，不停的逃，只要逃出這個鬼地方，就能活下來，就能想辦法找到Callie！[l]
@quake time="5000" vmax="20" hmax="20"
@bg time="1000" method="crossfade" storage="mountain006_cloud"
激勵著自己，青年又加快了腳步，再跑20分鐘就能接近密林的邊緣，之後只要順著山坡滑下，就能逃離精靈們的索敵魔法。[w]
“已經，看得到希望了……” Lucius小聲的對自己說。[lr]
@r
或許命運弄人描述的就是這種情況吧，一小抹幽幽的綠影從Lucius的眼前飛過，
@bg storage="magic24+"
這突如其來的情況讓Lucius的腦子瞬間停止了思考，雙腳馬上停下，抬起槍，用最快的速度瞄準那轉瞬即逝的影子，3點射，綠影應聲落下。
@bg storage="mountain006_cloud"
@w
“嘖！索敵用的sylph么！”，[l]這種風妖精是精靈常用的索敵手段，精靈們通常會通過臨時契約和風妖精共享一部分視覺，契約的有效距離大概是1公里左右。[l]
Lucius沒有理會被自己打穿的風妖精的尸體，繼續奔跑已经沒有用處，既然索敵用的風妖精已經飛到自己面前了，那麼自己的位置肯定也暴露了，已經無路可逃了。[w]
這種長耳朵的雜種們會讓土屬性的妖精們聚集到這裡，生成巨大人形巨石像拍扁自己吧……[l]
自己的槍法雖然好到能射殺飛行著的風妖精，但是對潛伏在地裡的土妖精一點辦法都沒有。或許自己Thanatos一樣被雷魔法劈死也說不定呢。[l]
Lucius自嘲的笑了一下，握緊了手中的槍，看了看彈夾，還有3顆子彈，備用的左輪手槍還有3顆子彈，一把尼泊爾短刀……[w]
@r
“可能的話，我還是想找一兩個長耳朵的雜種來墊背呢！”[lr]
[r]
Lucius撿起了地上風妖精的尸體，頭也不回的朝着反方向的密林深处走去。
@bg time="2000" storage="mountain004_cloud"
@w
@clbg hidemes="1"
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
@links target="*輸入完畢" hint="點這裡繼續~" text="確定"
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
