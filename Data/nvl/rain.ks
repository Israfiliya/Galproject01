@if exp="typeof(global.rain_object) == 'undefined'"
@iscript

/*
	雨
*/

class RainGrain
{
	// 雨粒

	var fore; // 表畫面雨粒
	var back; // 裏畫面雨粒
	var xvelo; // 橫速度
	var yvelo; // 縱速度
	var l, t; // 橫位置縱位置
	var ownwer; // 所有 RainPlugin 
	var spawned = false; // 雨粒出現
	var window; // 參照

	function RainGrain(window, n, owner)
	{
		// RainGrain 
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.absolute = 1000-1; // 重合順序履歷奧
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // 全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("rain_0" + "_" + intrandom(0, 3)); // 畫像讀迂
		back.assignImages(fore);
		var h = int(fore.imageHeight * (1.0 - n * 0.1));
		fore.setSizeToImageSize(); // 畫像同
		back.setSizeToImageSize();
		fore.height = h;
		fore.imageTop = -(fore.imageHeight - h);
		back.height = h;
		back.imageTop = -(fore.imageHeight - h);
		var opa = 255 - n * 20;
		fore.opacity = opa;
		back.opacity = opa;
		xvelo = 0; //Math.random() - 0.5; // 橫方向速度
		yvelo = (5 - n) * 30 + 75 + Math.random() * 15; // 縱方向速度
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 出現
		l = Math.random() * window.primaryLayer.width; // 橫初期位置
		t = -fore.height; // 縱初期位置
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // 裏畫面位置同
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 表示・非表示狀態再設定
		if(spawned)
		{
			fore.visible = owner.foreVisible;
			back.visible = owner.backVisible;
		}
		else
		{
			fore.visible = false;
			back.visible = false;
		}
	}

	function move()
	{
		// 雨粒動
		if(!spawned)
		{
			// 出現出現機會
			if(Math.random() < 0.002) spawn();
		}
		else
		{
			l += xvelo;
			t += yvelo;
			if(t >= window.primaryLayer.height)
			{
				t = -int(fore.height * Math.random());
				l = Math.random() * window.primaryLayer.width;
			}
			fore.setPos(l, t);
			back.setPos(l, t); // 裏畫面位置同
		}
	}

	function exchangeForeBack()
	{
		// 表裏管理情報交換
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class RainPlugin extends KAGPlugin
{
	// 雨振

	var rains = []; // 雨粒
	var timer; // 
	var window; // 參照
	var foreVisible = true; // 表畫面表示狀態
	var backVisible = true; // 裏畫面表示狀態

	function RainPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize 
		// 管理明示的破棄
		for(var i = 0; i < rains.count; i++)
			invalidate rains[i];
		invalidate rains;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		// num 個雨粒出現
		if(timer !== void) return; // 雨粒

		// 雨粒作成
		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 5); // 雨粒大 (  )
			rains[i] = new RainGrain(window, n, this);
		}
		rains[0].spawn(); // 最初雨粒最初表示

		// 作成
		timer = new Timer(onTimer, '');
		timer.interval = 80;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // 設定
	}

	function uninit()
	{
		// 雨粒消
		if(timer === void) return; // 雨粒

		for(var i = 0; i < rains.count; i++)
			invalidate rains[i];
		rains.count = 0;

		invalidate timer;
		timer = void;
	}

	function setOptions(elm)
	{
		// 設定
		foreVisible = +elm.forevisible if elm.forevisible !== void;
		backVisible = +elm.backvisible if elm.backvisible !== void;
		resetVisibleState();
	}

	function onTimer()
	{
		// 週期呼
		var raincount = rains.count;
		for(var i = 0; i < raincount; i++)
			rains[i].move(); // move 呼出
	}

	function resetVisibleState()
	{
		// 雨粒 表示・非表示狀態再設定
		var raincount = rains.count;
		for(var i = 0; i < raincount; i++)
			rains[i].resetVisibleState(); // resetVisibleState 呼出
	}

	function onStore(f, elm)
	{
		// 刊保存
		var dic = f.rains = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.rainCount = rains.count;
	}

	function onRestore(f, clear, elm)
	{
		// 刊讀出
		var dic = f.rains;
		if(dic === void || !+dic.init)
		{
			// 雨
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 雨
			init(dic.rainCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

	function onCopyLayer(toback)
	{
		// 表←→裏情報
		// 情報表示・非表示情報
		if(toback)
		{
			// 表→裏
			backVisible = foreVisible;
		}
		else
		{
			// 裏→表
			foreVisible = backVisible;
		}
		resetVisibleState();
	}

	function onExchangeForeBack()
	{
		// 裏表管理情報交換
		var raincount = rains.count;
		for(var i = 0; i < raincount; i++)
			rains[i].exchangeForeBack(); // move 呼出
	}
}

kag.addPlugin(global.rain_object = new RainPlugin(kag));
	// 作成、登錄

@endscript
@endif
; 登錄
@macro name="raininit"
@eval exp="mp.num=17" cond=(mp.num===void)
@eval exp="rain_object.init(+mp.num, mp)"
@endmacro
@macro name="rainuninit"
@eval exp="rain_object.uninit()"
@endmacro
@macro name="rainopt"
@eval exp="rain_object.setOptions(mp)"
@endmacro
@return

