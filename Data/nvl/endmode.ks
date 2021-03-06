;------------------------------------------------------------
;非常懶惰的END顯示
;------------------------------------------------------------
*start
[tempsave place="2"]

[iscript]

//假如是第一次登錄END，建立空白的END登陸記錄
if (sf.endlist==void) sf.endlist=%[];

//載入結局列表
f.endlist=[].load("endlist.txt");

//根據結局數，計算需要的翻頁數
tf.END頁數=f.endlist.count\f.config_endmode.locate.count;
if (f.endlist.count%f.config_endmode.locate.count>0) tf.END頁數++;
tf.當前END頁=1;

[endscript]
;------------------------------------------------------------
*window
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="endmode.ks" target=*返回]

[backlay]

[image layer=11 page=back storage=&"f.config_endmode.bgd" left=0 top=0 visible="true"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描繪各種ABC
[draw_endlist]
[trans method="crossfade" time=300]
[wt]

[s]

;------------------------------------------------------------
*刷新畫面
[image layer=11 page=fore storage=&"f.config_endmode.bgd" left=0 top=0 visible="true"]

[locklink]
[rclick enabled="true" jump="true" storage="endmode.ks" target=*返回]
;避免按鍵太快，等待100毫秒
[wait time=100]
[current layer="message4"]
[er]
;描繪各種ABC
[draw_endlist]
[s]

*結局跳轉
;準備加載結局
[locklink]
[rclick enabled="false" call="true" storage="rclick.ks" target=*隱藏對話框]
[fadeoutbgm time="1000"]

[backlay]
;恢復到界面初始狀態
[tempload place=2 backlay="true"]
;背景清空
[freeimage layer="base" page="back"]
[freeimage layer="11" page="back"]
;message0清空
[current layer="message0" page="back"]
[er]
[trans method="crossfade" time=200]
[wt]

[current layer="message0"]

[eval exp="dm('選擇了結局：'+tf.結局)"]

[call storage=&"tf.結局+'.ks'"]

;重置對話框
[frame]
;假如當前播放的不是標題背景音樂，恢復標題背景音樂
[bgm storage=&"f.config_title.bgm" cond="kag.bgm.playingStorage!=f.config_title.bgm"]

[jump storage="endmode.ks" target="*window"]

;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false" place="2"]
[trans method="crossfade" time=200]
[wt]

[return]
