require "import"
import "mods.muk"

import "androidx.recyclerview.widget.GridLayoutManager"
import "androidx.recyclerview.widget.*"
import "androidx.recyclerview.widget.RecyclerView"

import "com.pretend.recyclerview.lua.adapter.LuaAdapterCreator"
import "com.pretend.recyclerview.lua.adapter.LuaRecyclerHolder"
import "com.pretend.recyclerview.lua.adapter.LuaRecyclerViewAdapter"

import "com.pretend.recyclerview.LuaSpanSizeLookup"
import "com.pretend.recyclerview.LuaSpanSizeLookup$luaSpanSizeLookup"

activity.Title = "管理米游社账号"

layout = {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "fill",
    Gravity = "center|top",
    background = backgroundc;
    {
        LinearLayout,
        layout_width = "fill",
        layout_height = "56dp",
        gravity = "center|left";
        id = "mActionBar";
        {
            LinearLayout;
            orientation = "horizontal";
            layout_height = "56dp";
            layout_width = "56dp";
            gravity = "center";
            {
                ImageView;
                ColorFilter = primaryc;
                src = 图标("arrow_back");
                layout_height = "32dp";
                layout_width = "32dp";
                padding = "4dp";
                id = "fh";
                onClick = function() activity.finish() end;
            };
        };
        {
            TextView;
            text = "管理米游社账号";
            textColor = primaryc;
            textSize = "20sp";
            id = "_title";
            SingleLine = true;
            layout_width = "-1",
            gravity = "center|left";
            paddingLeft = "16dp";
            layout_weight = "1",
            Typeface = AppFont.特粗;
        };
    };

    {
        RelativeLayout,
        {
            RecyclerView,
            --layout_marginTop="20dp",
            layout_width = "-1",
            layout_height = "-1",
            id = "rv",
            paddingLeft = "8dp",
            paddingRight = "8dp",
        },
        {
            LinearLayout;
            layout_height = "-1";
            layout_width = "-1";
            orientation = "vertical";
            gravity = "bottom|right";
            paddingBottom = "0",
            {
                CardView;
                CardElevation = "0";
                CardBackgroundColor = 转0x(ctbackc);
                --outlineSpotShadowColor=转0x(primaryc),
                Radius = "24dp";
                layout_width = "-2";
                layout_height = "48dp";
                layout_margin = "24dp";
                id = "xf1";
                translationZ = "4dp";
                {
                    LinearLayout;
                    layout_height = "-1";
                    layout_width = "-1";
                    id = "cv1_lay";
                    gravity = "center";
                    paddingLeft = "12dp",
                    paddingRight = "24dp",
                    onClick = function()
                        双按钮对话框("选择登录方式", "",
                            "账号密码登录", "输入cookie", function()
                                关闭对话框()
                                activity.newActivity("tools/login")
                            end, function()
                            关闭对话框()

                            local data = {}
                            xpcall(function()
                                data = JSON.decode(mukactivity.getData("myscookies"))
                            end, function(e)
                                mukactivity.setData("myscookies", JSON.encode({}))
                                data = JSON.decode(mukactivity.getData("myscookies"))
                            end)

                            xpcall(function()
                                dann = {
                                    LinearLayout;
                                    layout_width = "-1";
                                    layout_height = "-1";
                                    {
                                        LinearLayout;
                                        orientation = "vertical";
                                        layout_width = "-1";
                                        layout_height = "-2";
                                        id = "ztbj";
                                        {
                                            TextView;
                                            layout_width = "-1";
                                            layout_height = "-2";
                                            textSize = "20sp";
                                            layout_marginTop = "24dp";
                                            layout_marginLeft = "24dp";
                                            layout_marginRight = "24dp";
                                            Text = "输入cookie";
                                            Typeface = AppFont.特粗;
                                            textColor = primaryc;
                                        };
                                        {
                                            MEditText
                                            {
                                                textSize = "14sp",
                                                textColor = textc;
                                                HintTextColor = stextc;
                                                hint = "请输入有效的cookie";
                                                layout_width = "-1";
                                                layout_height = "-1";
                                                --text="#2196F3";
                                                id = "strength_edit",
                                            };
                                            layout_marginTop = "8dp";
                                            layout_margin = "24dp";
                                            layout_marginBottom = "8dp";
                                            layout_height = "112dp";
                                        };
                                        {
                                            LinearLayout;
                                            orientation = "horizontal";
                                            layout_width = "-1";
                                            layout_height = "-2";
                                            gravity = "right|center";
                                            {
                                                CardView;
                                                layout_width = "-2";
                                                layout_height = "-2";
                                                radius = "4dp";
                                                background = primaryc;
                                                layout_marginTop = "8dp";
                                                layout_marginLeft = "8dp";
                                                layout_marginRight = "24dp";
                                                layout_marginBottom = "24dp";
                                                Elevation = "1dp";
                                                onClick = function()
                                                    关闭对话框()
                                                    加载对话框("正在确认cookie是否有效", "请稍等")

                                                    if tostring(strength_edit.Text) == nil and
                                                        tostring(strength_edit.Text) == "" then
                                                        提示("内容不能为空")
                                                        return true
                                                    end
                                                    local cookie = tostring(strength_edit.Text)

                                                    Http.get(
                                                        "https://api-takumi.mihoyo.com/binding/api/getUserGameRolesByCookie?game_biz=hk4e_cn"
                                                        ,
                                                        cookie,
                                                        nil,
                                                        nil,
                                                        function(code, content)
                                                            关闭对话框()
                                                            if code ~= 200 then
                                                                提示("获取cookie可用性失败")
                                                            end

                                                            local content = JSON.decode(content)
                                                            printLog("getUserGameRolesByCookie", content)

                                                            if content.data == nil then
                                                                提示("cookie不可用")
                                                                return true
                                                            end
                                                            if #content.data.list == 0 then
                                                                提示("cookie不可用")
                                                                return true
                                                            end
                                                            enterCookieName(cookie)
                                                        end)
                                                end;
                                                {
                                                    TextView;
                                                    layout_width = "-1";
                                                    layout_height = "-2";
                                                    textSize = "16sp";
                                                    paddingRight = "16dp";
                                                    paddingLeft = "16dp";
                                                    Typeface = AppFont.特粗;
                                                    paddingTop = "8dp";
                                                    paddingBottom = "8dp";
                                                    Text = "确定";
                                                    textColor = backgroundc;
                                                    BackgroundDrawable = activity.Resources.getDrawable(ripples).setColor(ColorStateList(int
                                                        [0].class { int {} }, int { bwz }));
                                                };
                                            };
                                        };
                                    };
                                };

                                dl = BottomDialog(activity)
                                dl.setView(loadlayout(dann))
                                dl.setGravity(Gravity.BOTTOM)
                                dl.setHeight(WindowManager.LayoutParams.WRAP_CONTENT)
                                dl.setMinHeight(0)
                                dl.setWidth(WindowManager.LayoutParams.MATCH_PARENT)
                                --设置圆角
                                dl.setRadius(dp2px(16), 转0x(backgroundc))

                                an = dl.show()
                                dl.setCanceledOnTouchOutside(true);
                            end, function(e)
                                提示("出现错误：\n" .. e)
                            end)

                        end)
                    end;
                    {
                        ImageView;
                        layout_width = "32dp";
                        layout_height = "32dp";
                        padding = "4dp";
                        ColorFilter = primaryc;
                        src = 图标("add");
                        id = "_add";
                    };
                    {
                        TextView;
                        text = "添加账号";
                        textColor = primaryc;
                        textSize = "16sp";
                        layout_width = "-1",
                        gravity = "center|left";
                        paddingLeft = "2dp";
                        layout_weight = "1",
                        Typeface = AppFont.粗体;
                    };
                },
            };
        };
    },
}

activity.setContentView(loadlayout(layout))

function onCreate()
    波纹({ cv1_lay }, "方主题")
    波纹({ fh }, "圆主题")

    function 设置Cookie(context, url, content)
        CookieSyncManager.createInstance(context)
        local cookieManager = CookieManager.getInstance()
        cookieManager.setAcceptCookie(true)
        cookieManager.removeSessionCookie()
        cookieManager.removeAllCookie()
        cookieManager.setCookie(url, content)
        CookieSyncManager.getInstance().sync()
    end

    tool_list_item = {
        LinearLayout;
        layout_width = "-1";
        layout_height = "-2";
        onClick = function() end;
        {
            CardView;
            CardElevation = "0dp";
            CardBackgroundColor = cardbackc;
            Radius = "8dp";
            layout_width = "-1";
            layout_height = "-2";
            layout_margin = "8dp";
            id = "tlb";
            {
                LinearLayout,
                orientation = "vertical",
                layout_width = "-1",
                layout_height = "-1",
                {
                    TextView;
                    id = "tladp_text";
                    textSize = "16sp";
                    gravity = "left|center";
                    Typeface = AppFont.粗体;
                    layout_width = "-1";
                    layout_height = "-1";
                    padding = "16dp";
                    paddingTop = "14dp";
                    paddingBottom = "14dp";
                    textColor = textc,
                    onClick = function(v)
                        if v.Text == 默认提示 then
                            return true
                        end
                        local data = {}
                        xpcall(function()
                            data = JSON.decode(mukactivity.getData("myscookies"))
                        end, function(e)
                            mukactivity.setData("myscookies", JSON.encode({}))
                            data = JSON.decode(mukactivity.getData("myscookies"))
                        end)

                        mukactivity.setData("myscookie", data[v.Text])
                        --设置Cookie(this,".mihoyo.com",data[v.Text])
                        --print(data[v.Text])

                        提示("设置成功")
                    end;
                    OnLongClickListener = function(v)
                        if v.Text == 默认提示 then
                            return true
                        end

                        local dann = {
                            LinearLayout,
                            layout_width = "-1",
                            layout_height = "-1",
                            {
                                LinearLayout,
                                orientation = "vertical",
                                layout_width = "-1",
                                layout_height = "-2",
                                id = "ztbj",
                                {
                                    TextView,
                                    layout_width = "-1",
                                    layout_height = "-2",
                                    textSize = "20sp",
                                    layout_marginTop = "24dp",
                                    layout_marginLeft = "24dp",
                                    layout_marginRight = "24dp",
                                    Text = "操作账号 " .. v.Text,
                                    Typeface = AppFont.特粗,
                                    textColor = primaryc
                                },
                                {
                                    ScrollView,
                                    layout_width = "-1",
                                    layout_height = "-1",
                                    layout_weight = "1",
                                    {
                                        TextView,
                                        layout_width = "-1",
                                        layout_height = "-2",
                                        textSize = "14sp",
                                        layout_marginTop = "8dp",
                                        layout_marginLeft = "24dp",
                                        layout_marginRight = "24dp",
                                        layout_marginBottom = "8dp",
                                        Typeface = AppFont.标准,
                                        Text = "*请仔细查看以下内容：\n米游社Cookie需要谨慎使用！\n尽量不要将米游社Cookie发给他人！"
                                            .. "\n他人有了您的Cookie相当于有了您的米游社登录状态！\n若账号出现异常请及时修改米游社密码！"
                                            .. "\n应急食品承诺不会将您的Cookie泄露给任何人，同时您的Cookie仅会用于米游社大地图、米游社签到和实时便笺。",
                                        textColor = textc,
                                        id = "sandhk_wb"
                                    },
                                },
                                {
                                    CardView,
                                    CardElevation = "0dp",
                                    CardBackgroundColor = 转0x(primaryc) - 0xde000000,
                                    Radius = "8dp",
                                    layout_width = "-1",
                                    layout_height = "-2",
                                    layout_marginLeft = "24dp",
                                    layout_marginRight = "24dp",
                                    layout_marginTop = "4dp",
                                    layout_marginBottom = "8dp",
                                    {
                                        TextView,
                                        layout_width = "-1",
                                        layout_height = "-1",
                                        textSize = "14sp",
                                        paddingRight = "16dp",
                                        paddingLeft = "16dp",
                                        Typeface = AppFont.特粗,
                                        paddingTop = "12dp",
                                        paddingBottom = "12dp",
                                        gravity = "center",
                                        Text = "复制Cookie",
                                        textColor = primaryc,
                                        background = 波纹2("方主题"),
                                        onClick = function()
                                            关闭对话框()
                                            local data = {}
                                            xpcall(function()
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end, function(e)
                                                mukactivity.setData("myscookies", JSON.encode({}))
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end)

                                            复制文本(data[v.Text])
                                            提示("已复制")
                                        end,
                                    }
                                },
                                {
                                    CardView,
                                    CardElevation = "0dp",
                                    CardBackgroundColor = cardbackc,
                                    Radius = "8dp",
                                    layout_width = "-1",
                                    layout_height = "-2",
                                    layout_margin = "8dp",
                                    layout_marginLeft = "24dp",
                                    layout_marginRight = "24dp",
                                    layout_marginTop = "8dp",
                                    layout_marginBottom = "8dp",
                                    {
                                        TextView,
                                        layout_width = "-1",
                                        layout_height = "-1",
                                        textSize = "14sp",
                                        paddingRight = "16dp",
                                        paddingLeft = "16dp",
                                        Typeface = AppFont.标准,
                                        paddingTop = "12dp",
                                        paddingBottom = "12dp",
                                        gravity = "center",
                                        Text = "重命名",
                                        textColor = textc,
                                        background = 波纹2("方自适应"),
                                        onClick = function()
                                            关闭对话框()
                                            local data = {}
                                            xpcall(function()
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end, function(e)
                                                mukactivity.setData("myscookies", JSON.encode({}))
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end)

                                            enterCookieName(nil, v.Text)
                                        end,
                                    }
                                },
                                {
                                    CardView,
                                    CardElevation = "0dp",
                                    CardBackgroundColor = cardbackc,
                                    Radius = "8dp",
                                    layout_width = "-1",
                                    layout_height = "-2",
                                    layout_margin = "8dp",
                                    layout_marginLeft = "24dp",
                                    layout_marginRight = "24dp",
                                    layout_marginTop = "8dp",
                                    layout_marginBottom = "8dp",
                                    {
                                        TextView,
                                        layout_width = "-1",
                                        layout_height = "-1",
                                        textSize = "14sp",
                                        paddingRight = "16dp",
                                        paddingLeft = "16dp",
                                        Typeface = AppFont.标准,
                                        paddingTop = "12dp",
                                        paddingBottom = "12dp",
                                        gravity = "center",
                                        Text = "重新登录",
                                        textColor = textc,
                                        background = 波纹2("方自适应"),
                                        onClick = function()
                                            关闭对话框()
                                            activity.newActivity("tools/login", { true })
                                            function relogin(cookie)
                                                local data = {}
                                                xpcall(function()
                                                    data = JSON.decode(mukactivity.getData("myscookies"))
                                                end, function(e)
                                                    mukactivity.setData("myscookies", JSON.encode({}))
                                                    data = JSON.decode(mukactivity.getData("myscookies"))
                                                end)

                                                data[v.Text] = cookie
                                                mukactivity.setData("myscookies", JSON.encode(data))

                                                更新()
                                            end
                                        end,
                                    }
                                },
                                {
                                    CardView,
                                    CardElevation = "0dp",
                                    CardBackgroundColor = 0x21F44336,
                                    Radius = "8dp",
                                    layout_width = "-1",
                                    layout_height = "-2",
                                    layout_marginLeft = "24dp",
                                    layout_marginRight = "24dp",
                                    layout_marginTop = "8dp",
                                    layout_marginBottom = "24dp",
                                    {
                                        TextView,
                                        layout_width = "-1",
                                        layout_height = "-1",
                                        textSize = "14sp",
                                        paddingRight = "16dp",
                                        paddingLeft = "16dp",
                                        Typeface = AppFont.标准,
                                        paddingTop = "12dp",
                                        paddingBottom = "12dp",
                                        gravity = "center",
                                        Text = "删除账号",
                                        textColor = "#F44336",
                                        background = 波纹2("方", 0xffF44336),
                                        onClick = function()
                                            关闭对话框()
                                            local data = {}
                                            xpcall(function()
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end, function(e)
                                                mukactivity.setData("myscookies", JSON.encode({}))
                                                data = JSON.decode(mukactivity.getData("myscookies"))
                                            end)

                                            data[v.Text] = nil
                                            mukactivity.setData("myscookies", JSON.encode(data))

                                            更新()
                                        end,
                                    },
                                },
                            }
                        }

                        dl = BottomDialog(activity)
                        dl.setView(loadlayout(dann))
                        dl.setGravity(Gravity.BOTTOM)
                        dl.setHeight(WindowManager.LayoutParams.WRAP_CONTENT)
                        dl.setMinHeight(0)
                        dl.setWidth(WindowManager.LayoutParams.MATCH_PARENT)
                        --设置圆角
                        dl.setRadius(dp2px(16), 转0x(backgroundc))
                        if gb == 0 then
                            dl.setCancelable(false)
                            dl.setCanceledOnTouchOutside(false)
                            dl.onDismiss = function()
                                an = dl.show()
                            end
                        else
                            dl.setCanceledOnTouchOutside(true)
                        end
                        an = dl.show()
                        return true
                    end;
                };
            };
        };
    };

    --tladp=LuaAdapter(activity,tool_list_item)

    --gv.setAdapter(tladp)

    默认提示 = "点击账号可设置为默认账号，长按账号可 复制Cookies 或 删除账号。（默认账号用于实时便笺，签到会给所有账号签到，重新登录后默认账号需要再次设置）\n注：在米游社客户端或在网页端退出登录会导致本软件内登录失效。"

    function addt(name)
        data[#data + 1] = { name }
    end

    data = {}

    function 更新()
        data = {}
        addt(默认提示)

        local data2 = {}
        xpcall(function()
            data2 = JSON.decode(mukactivity.getData("myscookies"))
        end, function(e)
            mukactivity.setData("myscookies", JSON.encode({}))
            data2 = JSON.decode(mukactivity.getData("myscookies"))
        end)

        for i, v in pairs(data2) do
            addt(i)
        end
        adp.notifyDataSetChanged()
    end

    rholder = function(parent, viewType)
        local views = {}
        holder = LuaRecyclerHolder(loadlayout(tool_list_item, views))
        holder.view.setTag(views)
        return holder
    end

    adp = LuaRecyclerViewAdapter(LuaAdapterCreator({
        getItemCount = function()
            return #data
        end,
        getItemViewType = function(position)
            return 0
        end,
        onCreateViewHolder = rholder,
        onBindViewHolder = function(holder, position)
            view = holder.view.getTag()
            view.tladp_text.Text = data[position + 1]
            view.tladp_text.setBackgroundDrawable(波纹2("方自适应"))
        end,
    }))

    rv.setAdapter(adp)

    local gvmanager = GridLayoutManager(activity, 1)
        .setSpanSizeLookup(LuaSpanSizeLookup(luaSpanSizeLookup {
            getSpanSize = function(position)
                return int(1)
            end
        }))

    rv.setLayoutManager(gvmanager)

    更新()

    function enterCookieName(cookie, before)
        local data = {}
        xpcall(function()
            data = JSON.decode(mukactivity.getData("myscookies"))
        end, function(e)
            mukactivity.setData("myscookies", JSON.encode({}))
            data = JSON.decode(mukactivity.getData("myscookies"))
        end)

        dann = {
            LinearLayout;
            layout_width = "-1";
            layout_height = "-1";
            {
                LinearLayout;
                orientation = "vertical";
                layout_width = "-1";
                layout_height = "-2";
                id = "ztbj";
                {
                    TextView;
                    layout_width = "-1";
                    layout_height = "-2";
                    textSize = "20sp";
                    layout_marginTop = "24dp";
                    layout_marginLeft = "24dp";
                    layout_marginRight = "24dp";
                    Text = "请输入备注";
                    Typeface = AppFont.特粗;
                    textColor = primaryc;
                };
                {
                    MEditText
                    {
                        textSize = "14sp",
                        textColor = textc;
                        HintTextColor = stextc;
                        hint = "备注（不要使用空格、符号等）";
                        layout_width = "-1";
                        layout_height = "-2";
                        --text="#2196F3";
                        id = "strength_edit",
                    };
                    layout_marginTop = "8dp";
                    layout_margin = "24dp";
                    layout_marginBottom = "8dp";
                };
                {
                    LinearLayout;
                    orientation = "horizontal";
                    layout_width = "-1";
                    layout_height = "-2";
                    gravity = "right|center";
                    {
                        CardView;
                        layout_width = "-2";
                        layout_height = "-2";
                        radius = "4dp";
                        background = primaryc;
                        layout_marginTop = "8dp";
                        layout_marginLeft = "8dp";
                        layout_marginRight = "24dp";
                        layout_marginBottom = "24dp";
                        Elevation = "1dp";
                        onClick = function()
                            if before then
                                if tostring(strength_edit.Text) == nil and tostring(strength_edit.Text) == "" then
                                    提示("内容不能为空")
                                    return true
                                end
                                local cookie = data[before]
                                data[before] = nil
                                data[tostring(strength_edit.Text)] = cookie
                                mukactivity.setData("myscookies", JSON.encode(data))

                                更新()

                                关闭对话框()
                            else
                                if tostring(strength_edit.Text) == nil and tostring(strength_edit.Text) == "" then
                                    提示("内容不能为空")
                                    return true
                                end
                                data[tostring(strength_edit.Text)] = cookie
                                mukactivity.setData("myscookies", JSON.encode(data))

                                更新()

                                关闭对话框()
                            end
                        end;
                        {
                            TextView;
                            layout_width = "-1";
                            layout_height = "-2";
                            textSize = "16sp";
                            paddingRight = "16dp";
                            paddingLeft = "16dp";
                            Typeface = AppFont.特粗;
                            paddingTop = "8dp";
                            paddingBottom = "8dp";
                            Text = "确定";
                            textColor = backgroundc;
                            BackgroundDrawable = activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class { int {} }
                                , int { bwz }));
                        };
                    };
                };
            };
        };

        dl = BottomDialog(activity)
        dl.setView(loadlayout(dann))
        dl.setGravity(Gravity.BOTTOM)
        dl.setHeight(WindowManager.LayoutParams.WRAP_CONTENT)
        dl.setMinHeight(0)
        dl.setWidth(WindowManager.LayoutParams.MATCH_PARENT)
        --设置圆角
        dl.setRadius(dp2px(16), 转0x(backgroundc))

        an = dl.show()
        dl.setCanceledOnTouchOutside(true);
    end

    cv1_lay.setOnTouchListener({
        onTouch = function(v, n)
            if tostring(n):find("ACTION_DOWN") then
                ObjectAnimator.ofFloat(xf1, "translationZ", { xf1.translationZ, dp2px(8) })
                    .setDuration(128)--设置动画时间
                    .setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
                    .start()
            elseif tostring(n):find("ACTION_UP") then
                ObjectAnimator.ofFloat(xf1, "translationZ", { xf1.translationZ, dp2px(4) })
                    .setDuration(128)--设置动画时间
                    .setInterpolator(AccelerateInterpolator())--设置动画插入器，减速
                    .start()
            end
        end
    })
end

function 分屏()
    local function setWidth(v, n)
        linearParams = v.getLayoutParams()
        linearParams.width = n
        v.setLayoutParams(linearParams)
    end

    local function setHeight(v, n)
        linearParams = v.getLayoutParams()
        linearParams.height = n
        v.setLayoutParams(linearParams)
    end

    if activity.Height * 0.9 < activity.Width then
        --横屏
        setHeight(mActionBar, dp2px(48))
    else
        setHeight(mActionBar, dp2px(56))
    end
end

function onConfigurationChanged(newConfig)
    分屏()
end

分屏()

function onResult(name, ...)
    if name == "tools/login" then
        cookie, re = ...
        if cookie then
            if re then
                relogin(cookie)
            else
                enterCookieName(cookie)
            end
        end
    end
end
