require "import"

import "mods.muk"

import "androidx.recyclerview.widget.GridLayoutManager"
import "androidx.recyclerview.widget.*"
import "androidx.recyclerview.widget.RecyclerView"

import "com.pretend.recyclerview.lua.adapter.LuaAdapterCreator"
import "com.pretend.recyclerview.lua.adapter.LuaRecyclerHolder"
import "com.pretend.recyclerview.lua.adapter.LuaRecyclerViewAdapter"

import "com.mukapp.observablescrollview.*"

import "com.pretend.recyclerview.LuaSpanSizeLookup"
import "com.pretend.recyclerview.LuaSpanSizeLookup$luaSpanSizeLookup"

import "mods.tanutai"

data,start_comment=...
data=luajava.astable(data,true)

activity.Title=data.title

layout={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
  Gravity="center|top",
  background=backgroundc;
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center|left";
    id="mActionBar";
    {
      LinearLayout;
      orientation="horizontal";
      layout_height="56dp";
      layout_width="56dp";
      gravity="center";
      {
        ImageView;
        ColorFilter=primaryc;
        src=图标("arrow_back");
        layout_height="32dp";
        layout_width="32dp";
        padding="4dp";
        id="fh";
        onClick=function()退出()end;
      };
    };
    {
      TextView;
      text=data.title;
      textColor=primaryc;
      textSize="20sp";
      id="_title";
      SingleLine=true;
      layout_width="-1",
      gravity="center|left";
      paddingLeft="16dp";
      layout_weight="1",
      Typeface=AppFont.特粗;
    };
  };

  {
    RelativeLayout,
    layout_height="-1";
    layout_width="-1";
    {
      SwipeRefreshLayout,
      layout_height="-1";
      layout_width="-1";
      id="tarefresh1",
      {
        ObservableRecyclerView,
        --layout_marginTop="20dp",
        layout_width="-1",
        layout_height="-1",
        id="tarv1",
      },
    },

    {
      LinearLayout;
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      gravity="bottom";
      {
        LinearLayout;--底栏
        layout_height="-2";
        layout_width="-1";
        gravity="center|left";
        background=backgroundc;
        elevation="6dp";
        orientation="vertical";
        onClick=function()end,
        {
          LinearLayout;--底栏
          orientation="horizontal";
          layout_height="48dp";
          layout_width="-1";
          gravity="center|left";
          paddingLeft="8dp",
          paddingRight="8dp",
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            layout_weight="1";
            gravity="left|center";
            onClick=function()end;
            paddingLeft="20dp",
            id="create_comment",
            {
              TextView;
              textSize="14sp";
              Text="发表评论";
              textColor=stextc;
              Typeface=AppFont.粗体;
            };
          };

          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            gravity="center";
            onClick=function()end;
            layout_marginRight="8dp",
            paddingLeft="0dp",
            paddingRight="0dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("star");
              id="star_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="star_count",
            };
          };
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            gravity="center";
            onClick=function()end;
            layout_marginRight="8dp",
            paddingLeft="0dp",
            paddingRight="0dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("thumb_down");
              id="vote_down_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="vote_down_count",
            };
          };
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            gravity="center";
            onClick=function()
            end;
            layout_marginRight="8dp",
            paddingLeft="0dp",
            paddingRight="0dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("comment");
              id="comment_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="comment_count",
            };
          };
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            gravity="center";
            onClick=function()end;
            layout_marginRight="16dp",
            paddingLeft="0dp",
            paddingRight="0dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("thumb_up");
              id="vote_up_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="vote_up_count",
            };
          };
        },
      },
    },
  },
}

activity.setContentView(loadlayout(layout))

function onCreate()
  波纹({fh},"圆主题")
  波纹({vote_up_count.getParent(),comment_count.getParent()
    ,vote_down_count.getParent(),star_count.getParent(),
    create_comment},"圆自适应")

  transitioner = LayoutTransition()
  mActionBar.setLayoutTransition(transitioner)

  控件不可见(_title)

  ta_item={
    LinearLayout,
    layout_width="-1";
    layout_height="-2";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        orientation="vertical";
        layout_height="-1";
        layout_width="-1";
        id="go",
        {
          LinearLayout;
          layout_height="-2";
          layout_width="-1";
          gravity="left|center",
          paddingTop="16dp",
          {
            CardView;
            CardElevation="0dp";
            CardBackgroundColor=cardbackc;
            Radius="16dp";
            layout_width="32dp";
            layout_height="32dp";
            layout_marginLeft="16dp";
            {
              ImageView;
              layout_height="-1";
              layout_width="-1";
              id="userimg",
            };
          },
          {
            LinearLayout;
            orientation="vertical";
            layout_height="-2";
            layout_width="-1";
            layout_weight="1",
            {
              TextView;
              textColor=textc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.粗体;
              paddingLeft="12dp";
              id="username",
            },
            {
              TextView;
              textColor=stextc;
              textSize="12sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="12dp";
              id="createtime",
            },
          },
          {
            CardView;
            CardElevation="0dp";
            CardBackgroundColor=转0x(primaryc)-0xafffffff;
            Radius="4dp";
            layout_width="8dp";
            layout_height="8dp";
            layout_marginRight="24dp";
          },
        };
        {
          TextView;
          textColor=textc;
          textSize="16sp";
          gravity="center|left";
          Typeface=AppFont.特粗;
          padding="16dp";
          paddingTop="8dp",
          paddingBottom="0";
          id="title",
        };
        {
          TextView;
          textColor=textc;
          textSize="14sp";
          gravity="center|left";
          Typeface=AppFont.标准;
          padding="16dp";
          paddingTop="4dp",
          paddingBottom="16dp";
          layout_width="-1";
          layout_height="-2";
          id="content",
        };
      },
    },
  }

  ta_item_comment={
    LinearLayout,
    layout_width="-1";
    layout_height="-2";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        orientation="vertical";
        layout_height="-1";
        layout_width="-1";
        id="go",
        {
          LinearLayout;
          layout_height="-2";
          layout_width="-1";
          gravity="left|center",
          paddingTop="16dp",
          {
            CardView;
            CardElevation="0dp";
            CardBackgroundColor=cardbackc;
            Radius="16dp";
            layout_width="32dp";
            layout_height="32dp";
            layout_marginLeft="16dp";
            {
              ImageView;
              layout_height="-1";
              layout_width="-1";
              id="userimg",
            };
          },
          {
            LinearLayout;
            orientation="vertical";
            layout_height="-2";
            layout_width="-1";
            layout_weight="1",
            {
              TextView;
              textColor=textc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.粗体;
              paddingLeft="12dp";
              id="username",
            },
            {
              TextView;
              textColor=stextc;
              textSize="12sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="12dp";
              id="updatetime",
            },
          },
          {
            CardView;
            CardElevation="0dp";
            CardBackgroundColor=转0x(primaryc)-0xafffffff;
            Radius="4dp";
            layout_width="8dp";
            layout_height="8dp";
            layout_marginRight="24dp";
          },
        };
        {
          TextView;
          textColor=textc;
          textSize="14sp";
          Typeface=AppFont.标准;
          padding="16dp";
          paddingTop="8dp",
          paddingBottom="4dp";
          layout_width="-1";
          layout_height="-2";
          id="content",
        };
        {
          LinearLayout;
          layout_height="-2";
          layout_width="-1";
          --paddingBottom="8dp",
          --paddingLeft="8dp",
          --paddingRight="8dp",
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            gravity="center",
            layout_weight="1",
            padding="8dp",
            paddingBottom="16dp",
            paddingLeft="16dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("thumb_down");
              id="vote_down_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="vote_down_count",
            };
          },
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            gravity="center",
            layout_weight="1",
            padding="8dp",
            paddingBottom="16dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("comment");
              id="comment_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="comment_count",
            };
          },
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            gravity="center",
            layout_weight="1",
            padding="8dp",
            paddingBottom="16dp",
            paddingRight="16dp",
            {
              ImageView;
              layout_width="28dp";
              layout_height="28dp";
              padding="4dp";
              ColorFilter=stextc;
              src=图标("thumb_up");
              id="vote_up_count_img";
            },
            {
              TextView;
              text="0",
              textColor=stextc;
              textSize="14sp";
              gravity="center|left";
              Typeface=AppFont.标准;
              paddingLeft="4dp",
              paddingRight="4dp",
              id="vote_up_count",
            };
          },
        },
      },
    },
  }

  ta_topic={
    LinearLayout,
    layout_width="-1";
    layout_height="-2";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        layout_height="-2";
        layout_width="-1";
        gravity="left|center",
        paddingTop="8dp",
        paddingBottom="8dp";
        {
          CardView;
          CardElevation="0dp";
          CardBackgroundColor=cardbackc;
          Radius="6dp";
          layout_width="72dp";
          layout_height="40dp";
          layout_marginLeft="8dp";
          {
            ImageView;
            layout_height="-1";
            layout_width="-1";
            scaleType="centerCrop";
            id="img",
          };
        },
        {
          TextView;
          textColor=textc;
          textSize="14sp";
          gravity="center|left";
          Typeface=AppFont.标准;
          padding="12dp";
          paddingTop="4dp",
          paddingBottom="4dp";
          id="topic",
        };
      },
    },
  }

  ta_comment_title={
    LinearLayout,
    layout_width="-1";
    layout_height="-2";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        layout_height="-2";
        layout_width="-1";
        gravity="left|center",
        {
          TextView;
          textColor=primaryc;
          textSize="16sp";
          gravity="center|left";
          Typeface=AppFont.特粗;
          padding="16dp";
          paddingLeft="16dp",
          text="评论",
        };
      },
    },
  }

  ta_empty={
    LinearLayout,
    layout_width="-1";
    layout_height="-2";
    {
      TextView,
      layout_width="-1";
      layout_height="-2";
      id="empty",
    },
  }

  ta_article_data={}

  local tableTheme = TableTheme.Builder()
  .tableCellPadding(dp2px(12))
  .tableBorderColor(转0x(cardbackc))
  .tableBorderWidth(dp2px(2))
  .tableOddRowBackgroundColor(转0x(cardbackc))
  .tableEvenRowBackgroundColor(转0x(cardbackc))
  .tableHeaderRowBackgroundColor(转0x(primaryc)-0x7f000000)
  .build()

  markwon = Markwon.builder(this)
  .usePlugin(MarkwonPlugin{
    configureTheme=function(builder)
      builder
      .linkColor(转0x(primaryc))
      .blockMargin(dp2px(16))--文本内容前的起始边距
      .blockQuoteWidth(dp2px(4))--引用条纹宽度
      .blockQuoteColor(转0x(primaryc))--引用条纹颜色
      .listItemColor(转0x(primaryc))--列表项颜色
      .bulletListItemStrokeWidth(dp2px(2))--项目符号列表项的边框宽度（2 级）
      .bulletWidth(dp2px(8))--项目符号的宽度
      .codeTextColor(转0x(textc))--内联代码
      .codeBackgroundColor(转0x(cardbackc))
      .codeBlockTextColor(转0x(textc))--块代码
      .codeBlockBackgroundColor(转0x(cardbackc))
      .codeBlockMargin(dp2px(8))--块代码内容的前导边距
      .headingBreakHeight(dp2px(12))--H1和H2下的刹车高度
      .headingBreakColor(转0x(primaryc)-0x7f000000)--H1和H2下刹车的颜色
      .headingTypeface(AppFont.粗体)--标题字体
      .thematicBreakColor(转0x(cardbackc))--主题休息的颜色
      .thematicBreakHeight(dp2px(2))--主题休息的高度
    end,
    configureConfiguration=function(builder)
      builder
      .linkResolver(LinkResolver{
        resolve=function(view,link)
          if link:find("^image%:%:") then
            activity.newActivity("tanutai/viewimage",{link:match("^image%:%:(.+)")})
           elseif link:find("^copy%:%:") then
            复制文本(link:match("^copy%:%:(.+)"))
            提示("已复制文本")
           elseif link:find("^bilibili%:%:") then
            提示("正在获取视频信息")
            local bv
            local page
            if link:find("|") then
              bv,page=link:match("^bilibili%:%:(.-)|(.+)")
             else
              bv=link:match("^bilibili%:%:(.+)")
            end
            local url="https://api.bilibili.com/x/web-interface/view?bvid="..bv
            Http.get(url,function(code,content)
              if code==200 then
                local content=JSON.decode(content)
                if content.code=="0" then
                  提示("获取视频信息失败："..content.message)
                 else
                  local aid=content.data.aid
                  local pages=content.data.pages
                  local pagesinfo={}
                  for i=1,#pages do
                    pagesinfo[#pagesinfo+1]={pages[i].cid,pages[i].dimension.width,pages[i].dimension.height,}
                  end
                  activity.newActivity("tanutai/bili",{aid,bv,pagesinfo,page})
                end
               else
                提示("获取视频信息失败："..code)
              end
            end)
           else
            if link:find("^http%:") or link:find("^https%:") then
              activity.newActivity("web",{link})
             else
              浏览器打开(link)
            end
          end
        end,
      })
    end,
    processMarkdown=function(x)
      --print(x)
      return x
    end
  })
  .usePlugin(MovementMethodPlugin.create(BetterLinkMovementMethod.getInstance()))
  .usePlugin(LinkifyPlugin.create())
  .usePlugin(GlideImagesPlugin.create(GlideImagesPlugin.GlideStore{
    load=function(drawable)
      local link=drawable.getDestination()
      local glideUrl
      if link:find("tpic.mukapp.top") then
        glideUrl = GlideUrl(link, LazyHeaders.Builder()
        .addHeader("Referer", "https://tanutai.mukapp.top")
        .build())
       else
        glideUrl = GlideUrl(link, LazyHeaders.Builder()
        --.addHeader("Referer", "https://tanutai.mukapp.top")
        .build())
      end
      return Glide.with(this)
      .load(glideUrl)
      .placeholder(BitmapDrawable(loadbitmap("res/loading_image.png")))
      .transition(DrawableTransitionOptions
      .with(DrawableCrossFadeFactory.Builder(328)
      .setCrossFadeEnabled(true).build()))
      .override(activity.Width-dp2px(16*2*2), dp2px(512))
      .transform({FitCenter(), RoundedCorners(dp2px(6))})
    end,
    cancel=function(target)
      Glide.with(this).clear(target)
    end,
  }))
  .usePlugin(StrikethroughPlugin.create())
  .usePlugin(TablePlugin.create(tableTheme))
  .usePlugin(TaskListPlugin.create(转0x(primaryc), 转0x(stextc), 转0x(backgroundc)))
  .usePlugin(HtmlPlugin.create(HtmlPlugin.HtmlConfigure{
    configureHtml=function(plugin)
      plugin.addHandler(SimpleTagHandlerImpl(CallBack{
        getSpans=function(configuration, renderProps, tag)
          local spans=ArrayList()
          if tag.attributes().get("color")~=nil
            and tag.attributes().get("color")~="" then
            spans.add(ForegroundColorSpan(转0x(tag.attributes().get("color"))))
          end
          return spans.toArray()
        end,
        supportedTags=function()
          return Collections.singleton("font")
        end,
      })
      )
    end
  }))
  .usePlugin(MarkwonInlineParserPlugin.create())
  .build()

  ta_article_adp=LuaRecyclerViewAdapter(LuaAdapterCreator({
    getItemCount=function()
      return #ta_article_data+4
    end,
    getItemViewType=function(position)
      if position==1 then
        return 0
       elseif position==0 then
        return 3
       elseif position==2 then
        return 4
       elseif position==#ta_article_data+2 then
        return 1
       elseif position==#ta_article_data+3 then
        return 5
       else
        return 2
      end
    end,
    onCreateViewHolder=function(parent,viewType)
      local viewType=tointeger(viewType)
      if viewType==0 then
        local views={}
        holder0=LuaRecyclerHolder(loadlayout(ta_item,views))
        holder0.view.setTag(views)
        return holder0
       elseif viewType==1 then
        local views={}
        holder1=LuaRecyclerHolder(loadlayout(ta_empty,views))
        holder1.view.setTag(views)
        return holder1
       elseif viewType==2 then
        local views={}
        holder2=LuaRecyclerHolder(loadlayout(ta_item_comment,views))
        holder2.view.setTag(views)
        return holder2
       elseif viewType==3 then
        local views={}
        holder3=LuaRecyclerHolder(loadlayout(ta_topic,views))
        holder3.view.setTag(views)
        return holder3
       elseif viewType==4 then
        local views={}
        holder4=LuaRecyclerHolder(loadlayout(ta_comment_title,views))
        holder4.view.setTag(views)
        return holder4
       elseif viewType==5 then
        local views={}
        holder5=LuaRecyclerHolder(loadlayout(ta_empty,views))
        holder5.view.setTag(views)
        return holder5
      end
    end,
    onBindViewHolder=function(holder,position,payload)
      local view=holder.view.getTag()
      if ta_article_adp.getItemViewType(position)==1 then
        local linearParams = view.empty.getLayoutParams()
        linearParams.height =dp2px(8+112)
        view.empty.setLayoutParams(linearParams)
       elseif ta_article_adp.getItemViewType(position)==5 then
        local linearParams = view.empty.getLayoutParams()
        linearParams.height =dp2px(48)
        view.empty.setLayoutParams(linearParams)
       elseif ta_article_adp.getItemViewType(position)==4 then
       elseif ta_article_adp.getItemViewType(position)==0 then
        local position=position
        view.title.Text=ta_article_data[position]["title"]
        view.username.Text=ta_article_data[position].relationships.user.username
        view.createtime.Text=友好时间(ta_article_data[position].create_time)

        --view.content.setText(Html.fromHtml(ta_article_data[position].content_rendered))

        local con=ta_article_data[position].content_markdown

        markwon.setMarkdown(view.content,con)
        --view.content.setText(markdownProcessor.parse(con))

        --[[view.content.post(Runnable{
        run=function()
          view.content.setTextIsSelectable(true)
        end
      })]]

        Glide.with(this)
        .load(ta_article_data[position].relationships.user.avatar.small)
        .transition(DrawableTransitionOptions
        .with(DrawableCrossFadeFactory.Builder(328)
        .setCrossFadeEnabled(true).build()))
        .into(view.userimg)
       elseif ta_article_adp.getItemViewType(position)==3 then
        view.topic.Text=data.relationships.topics[1].name
        Glide.with(this)
        .load(data.relationships.topics[1].cover.small)
        .transition(DrawableTransitionOptions
        .with(DrawableCrossFadeFactory.Builder(328)
        .setCrossFadeEnabled(true).build()))
        .into(view.img)
       elseif ta_article_adp.getItemViewType(position)==2 then
        local position=position-1
        --view.title.Text=ta_article_data[position+1]["title"]

        view.username.Text=ta_article_data[position].relationships.user.username
        view.updatetime.Text=友好时间(ta_article_data[position].create_time)
        if ta_article_data[position].relationships.voting=="up" then
          view.vote_up_count_img.setColorFilter(转0x(primaryc))
          view.vote_down_count_img.setColorFilter(转0x(stextc))
          view.vote_up_count.setTextColor(转0x(primaryc))
          view.vote_down_count.setTextColor(转0x(stextc))
         elseif ta_article_data[position].relationships.voting=="down" then
          view.vote_up_count_img.setColorFilter(转0x(stextc))
          view.vote_down_count_img.setColorFilter(转0x(primaryc))
          view.vote_up_count.setTextColor(转0x(stextc))
          view.vote_down_count.setTextColor(转0x(primaryc))
         else
          view.vote_up_count_img.setColorFilter(转0x(stextc))
          view.vote_down_count_img.setColorFilter(转0x(stextc))
          view.vote_up_count.setTextColor(转0x(stextc))
          view.vote_down_count.setTextColor(转0x(stextc))
        end

        if not ta_article_data[position].comment_count
          tanutai.getReplies(ta_article_data[position].comment_id,1,"-vote_count","user,voting",function(content)
            if content.pagination
              ta_article_data[position]._comment_count=content.pagination.total
             else
              ta_article_data[position]._comment_count=0
            end
            view.comment_count.Text=tostring(ta_article_data[position]._comment_count)
          end,
          function(code,content)
            view.comment_count.Text=tostring(ta_article_data[position]._comment_count)
          end)
         else

        end

        view.vote_up_count.Text=tostring(ta_article_data[position].vote_up_count)
        view.vote_down_count.Text=tostring(ta_article_data[position].vote_down_count)

        view.comment_count.getParent().setBackground(波纹2("方自适应"))
        view.comment_count.getParent().onClick=function()
        end

        view.vote_up_count.getParent().setBackground(波纹2("方自适应"))
        view.vote_up_count.getParent().onClick=function(v)
          ta_article_data[position].l_vote_up_count=ta_article_data[position].vote_up_count
          ta_article_data[position].l_vote_down_count=ta_article_data[position].vote_down_count
          ta_article_data[position].relationships.l_voting=ta_article_data[position].relationships.voting

          if ta_article_data[position].relationships.voting=="up" then
            local oldDatas=ta_article_data

            ta_article_data[position].vote_up_count=ta_article_data[position].vote_up_count-1
            ta_article_data[position].relationships.voting=""
            --ta_article_adp.notifyDataSetChanged()
            ta_article_adp.notifyItemChanged(position+1)

            tanutai.commentsVoters(ta_article_data[position].comment_id,nil,
            function(content)
              if content.code~=0 then
                提示("取消失败："..code)
                ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
                ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
                ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
                --ta_article_adp.notifyDataSetChanged()
                ta_article_adp.notifyItemChanged(position+1)
               else
              end
            end,
            function(code,content)
              提示("取消失败："..code)
              ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
              ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
              ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
              --ta_article_adp.notifyDataSetChanged()
              ta_article_adp.notifyItemChanged(position+1)
            end)
            return true
           elseif ta_article_data[position].relationships.voting=="down" then
            ta_article_data[position].vote_up_count=ta_article_data[position].vote_up_count+1
            ta_article_data[position].vote_down_count=ta_article_data[position].vote_down_count-1
           else
            ta_article_data[position].vote_up_count=ta_article_data[position].vote_up_count+1
          end
          ta_article_data[position].relationships.voting="up"
          --ta_article_adp.notifyDataSetChanged()
          ta_article_adp.notifyItemChanged(position+1)
          tanutai.commentsVoters(ta_article_data[position].comment_id,"up",
          function(content)
            --print(dump(content))
            if content.code~=0 then
              提示("点赞失败："..code)
              ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
              ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
              ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
              --ta_article_adp.notifyDataSetChanged()
              ta_article_adp.notifyItemChanged(position+1)
             else
            end
          end,
          function(code,content)
            提示("点赞失败："..code)
            ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
            ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
            ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
            --ta_article_adp.notifyDataSetChanged()
            ta_article_adp.notifyItemChanged(position+1)
          end)
        end

        view.vote_down_count.getParent().setBackground(波纹2("方自适应"))
        view.vote_down_count.getParent().onClick=function(v)
          ta_article_data[position].l_vote_up_count=ta_article_data[position].vote_up_count
          ta_article_data[position].l_vote_down_count=ta_article_data[position].vote_down_count
          ta_article_data[position].relationships.l_voting=ta_article_data[position].relationships.voting

          if ta_article_data[position].relationships.voting=="down" then
            ta_article_data[position].vote_down_count=ta_article_data[position].vote_down_count-1
            ta_article_data[position].relationships.voting=""
            --ta_article_adp.notifyDataSetChanged()
            ta_article_adp.notifyItemChanged(position+1)
            tanutai.commentsVoters(ta_article_data[position].comment_id,nil,
            function(content)
              if content.code~=0 then
                提示("取消失败："..code)
                ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
                ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
                ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
                --ta_article_adp.notifyDataSetChanged()
                ta_article_adp.notifyItemChanged(position+1)
               else
              end
            end,
            function(code,content)
              提示("取消失败："..code)
              ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
              ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
              ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
              --ta_article_adp.notifyDataSetChanged()
              ta_article_adp.notifyItemChanged(position+1)
            end)
            return true
           elseif ta_article_data[position].relationships.voting=="up" then
            ta_article_data[position].vote_up_count=ta_article_data[position].vote_up_count-1
            ta_article_data[position].vote_down_count=ta_article_data[position].vote_down_count+1
           else
            ta_article_data[position].vote_down_count=ta_article_data[position].vote_down_count+1
          end
          ta_article_data[position].relationships.voting="down"
          --ta_article_adp.notifyDataSetChanged()
          ta_article_adp.notifyItemChanged(position+1)
          tanutai.commentsVoters(ta_article_data[position].comment_id,"down",
          function(content)
            --print(dump(content))
            if content.code~=0 then
              提示("点踩失败："..code)
              ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
              ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
              ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
              --ta_article_adp.notifyDataSetChanged()
              ta_article_adp.notifyItemChanged(position+1)
             else
            end
          end,
          function(code,content)
            提示("点踩失败："..code)
            ta_article_data[position].vote_up_count=ta_article_data[position].l_vote_up_count
            ta_article_data[position].vote_down_count=ta_article_data[position].l_vote_down_count
            ta_article_data[position].relationships.voting=ta_article_data[position].relationships.l_voting
            --ta_article_adp.notifyDataSetChanged()
            ta_article_adp.notifyItemChanged(position+1)
          end)
        end

        --view.content.setText(Html.fromHtml(ta_article_data[position].content_rendered))

        local con=ta_article_data[position].content

        --view.content.setText(markdownProcessor.parse(con));
        markwon.setMarkdown(view.content,con)
        --view.content.setSpannableFactory(NoCopySpannableFactory.getInstance())

        Glide.with(this)
        .load(ta_article_data[position].relationships.user.avatar.small)
        .transition(DrawableTransitionOptions
        .with(DrawableCrossFadeFactory.Builder(328)
        .setCrossFadeEnabled(true).build()))
        .into(view.userimg)

        view.go.setBackground(波纹2("方自适应"))
        view.go.onClick=function()
          activity.newActivity("tanutai/comment",{ta_article_data[position]})
        end
        view.go.onLongClick=function()
          print()
          return true
        end
      end
    end,
  }))

  tarv1.setAdapter(ta_article_adp)
  tarv1_glm=GridLayoutManager(activity,1)
  .setSpanSizeLookup(LuaSpanSizeLookup(luaSpanSizeLookup{
    getSpanSize=function(position)
      return int(1)
    end,
    getSpanIndex=function(i,i2)
      return int(0)
    end,
  }))
  tarv1.setLayoutManager(tarv1_glm)

  tarv1_lPos = 0

  first_enter=true


  local last_type=0

  tarv1.setScrollViewCallbacks(
  ObservableScrollViewCallbacks {
    --滚动时
    onScrollChanged = function(scrollY, firstScroll, dragging)
      --print(scrollY,firstScroll,dragging)
      tarv1_lst = scrollY
      -- param scrollY 在Y轴滚动位置。
      -- firstScroll 是否是第一次（刚开始）滑动
      -- dragging 当前视图是否是因为拖拽而产生滑动
      if tarv1_lPos ~= tarv1_glm.findLastVisibleItemPosition() + 2 then
        tarv1_lPos = tarv1_glm.findLastVisibleItemPosition() + 2
        if (tarv1_lPos == ta_article_adp.getItemCount()) and tarv1_lPos > 5 then
          if not first_enter
            tarefresh1.setProgressViewOffset(true, dp2px(8), screenY - 导航栏高度 - dp2px(48 + 64 + 112 - 8))
            获取评论()
          end
         else
          tarefresh1.setProgressViewOffset(true, dp2px(8), dp2px(48))
        end
      end

      local rect = Rect()
      if tarv1_glm.findViewByPosition(1)
        local view = tarv1_glm.findViewByPosition(1).getTag()
        local isVisible = view.title.getGlobalVisibleRect(rect)
        if isVisible
          控件不可见(_title)
         else
          控件可见(_title)
        end
       else
        控件可见(_title)
      end
    end,
    --按下
    onDownMotionEvent = function()
      --print("按下")
    end,
    --拖拽结束或者取消时
    onUpOrCancelMotionEvent = function(scrollState)
      if (scrollState == ScrollState.DOWN) then
        --print("向下滚动1");
       elseif (scrollState == ScrollState.UP) then
        if tarv1_lst >= 5 then
          --print("向上滚动");
         else
          --print("向下滚动2");
        end
       else
        --print("停止滚动");
      end
    end
  }
  )

  ta_article_data[#ta_article_data+1]=data
  ta_article_adp.notifyDataSetChanged()

  function 初始()
    if data.relationships.voting=="up" then
      vote_up_count_img.setColorFilter(转0x(primaryc))
      vote_down_count_img.setColorFilter(转0x(stextc))
      vote_up_count.setTextColor(转0x(primaryc))
      vote_down_count.setTextColor(转0x(stextc))
     elseif data.relationships.voting=="down" then
      vote_up_count_img.setColorFilter(转0x(stextc))
      vote_down_count_img.setColorFilter(转0x(primaryc))
      vote_up_count.setTextColor(转0x(stextc))
      vote_down_count.setTextColor(转0x(primaryc))
     else
      vote_up_count_img.setColorFilter(转0x(stextc))
      vote_down_count_img.setColorFilter(转0x(stextc))
      vote_up_count.setTextColor(转0x(stextc))
      vote_down_count.setTextColor(转0x(stextc))
    end
    if data.relationships.is_following==true then
      star_img.setColorFilter(转0x(primaryc))
      star_count.setTextColor(转0x(primaryc))
     else
      star_img.setColorFilter(转0x(stextc))
      star_count.setTextColor(转0x(stextc))
    end
    comment_count.Text=tostring(data.comment_count)
    vote_up_count.Text=tostring(data.vote_up_count)
    vote_down_count.Text=tostring(data.vote_down_count)
    star_count.Text=tostring(data.follower_count)

    comment_count.getParent().onClick=function()
      tarv1_glm.scrollToPositionWithOffset(2,0);
    end

    vote_up_count.getParent().onClick=function(v)
      data.l_vote_up_count=data.vote_up_count
      data.l_vote_down_count=data.vote_down_count
      data.relationships.l_voting=data.relationships.voting

      if data.relationships.voting=="up" then
        local oldDatas=ta_article_data

        data.vote_up_count=data.vote_up_count-1
        data.relationships.voting=""
        --ta_article_adp.notifyDataSetChanged()
        初始()

        tanutai.articlesVoters(data.article_id,nil,
        function(content)
          if content.code~=0 then
            提示("取消失败："..code)
            data.vote_up_count=data.l_vote_up_count
            data.vote_down_count=data.l_vote_down_count
            data.relationships.voting=data.relationships.l_voting
            --ta_article_adp.notifyDataSetChanged()
            初始()
           else
          end
        end,
        function(code,content)
          提示("取消失败："..code)
          data.vote_up_count=data.l_vote_up_count
          data.vote_down_count=data.l_vote_down_count
          data.relationships.voting=data.relationships.l_voting
          --ta_article_adp.notifyDataSetChanged()
          初始()
        end)
        return true
       elseif data.relationships.voting=="down" then
        data.vote_up_count=data.vote_up_count+1
        data.vote_down_count=data.vote_down_count-1
       else
        data.vote_up_count=data.vote_up_count+1
      end
      data.relationships.voting="up"
      --ta_article_adp.notifyDataSetChanged()
      初始()
      tanutai.articlesVoters(data.article_id,"up",
      function(content)
        --print(dump(content))
        if content.code~=0 then
          提示("点赞失败："..code)
          data.vote_up_count=data.l_vote_up_count
          data.vote_down_count=data.l_vote_down_count
          data.relationships.voting=data.relationships.l_voting
          --ta_article_adp.notifyDataSetChanged()
          初始()
         else
        end
      end,
      function(code,content)
        提示("点赞失败："..code)
        data.vote_up_count=data.l_vote_up_count
        data.vote_down_count=data.l_vote_down_count
        data.relationships.voting=data.relationships.l_voting
        --ta_article_adp.notifyDataSetChanged()
        初始()
      end)
    end

    vote_down_count.getParent().onClick=function(v)
      data.l_vote_up_count=data.vote_up_count
      data.l_vote_down_count=data.vote_down_count
      data.relationships.l_voting=data.relationships.voting

      if data.relationships.voting=="down" then
        data.vote_down_count=data.vote_down_count-1
        data.relationships.voting=""
        --ta_article_adp.notifyDataSetChanged()
        初始()
        tanutai.articlesVoters(data.article_id,nil,
        function(content)
          if content.code~=0 then
            提示("取消失败："..code)
            data.vote_up_count=data.l_vote_up_count
            data.vote_down_count=data.l_vote_down_count
            data.relationships.voting=data.relationships.l_voting
            --ta_article_adp.notifyDataSetChanged()
            初始()
           else
          end
        end,
        function(code,content)
          提示("取消失败："..code)
          data.vote_up_count=data.l_vote_up_count
          data.vote_down_count=data.l_vote_down_count
          data.relationships.voting=data.relationships.l_voting
          --ta_article_adp.notifyDataSetChanged()
          初始()
        end)
        return true
       elseif data.relationships.voting=="up" then
        data.vote_up_count=data.vote_up_count-1
        data.vote_down_count=data.vote_down_count+1
       else
        data.vote_down_count=data.vote_down_count+1
      end
      data.relationships.voting="down"
      --ta_article_adp.notifyDataSetChanged()
      初始()
      tanutai.articlesVoters(data.article_id,"down",
      function(content)
        --print(dump(content))
        if content.code~=0 then
          提示("点踩失败："..code)
          data.vote_up_count=data.l_vote_up_count
          data.vote_down_count=data.l_vote_down_count
          data.relationships.voting=data.relationships.l_voting
          --ta_article_adp.notifyDataSetChanged()
          初始()
         else
        end
      end,
      function(code,content)
        提示("点踩失败："..code)
        data.vote_up_count=data.l_vote_up_count
        data.vote_down_count=data.l_vote_down_count
        data.relationships.voting=data.relationships.l_voting
        --ta_article_adp.notifyDataSetChanged()
        初始()
      end)
    end

    star_count.getParent().onClick=function(v)
      data.l_follower_count=data.follower_count
      data.relationships.l_is_following=data.relationships.is_following

      if data.relationships.is_following then
        local oldDatas=ta_article_data

        data.follower_count=data.follower_count-1
        data.relationships.is_following=false
        --ta_article_adp.notifyDataSetChanged()
        初始()

        tanutai.follow(data.article_id,nil,
        function(content)
          if content.code~=0 then
            提示("取消收藏失败："..code)
            data.follower_count=data.l_follower_count
            data.relationships.is_following=data.relationships.l_is_following
            --ta_article_adp.notifyDataSetChanged()
            初始()
           else
          end
        end,
        function(code,content)
          提示("取消收藏失败："..code)
          data.follower_count=data.l_follower_count
          data.relationships.is_following=data.relationships.l_is_following
          --ta_article_adp.notifyDataSetChanged()
          初始()
        end)
       else
        local oldDatas=ta_article_data

        data.follower_count=data.follower_count+1
        data.relationships.is_following=true
        --ta_article_adp.notifyDataSetChanged()
        初始()

        tanutai.follow(data.article_id,true,
        function(content)
          if content.code~=0 then
            提示("收藏失败："..code)
            data.follower_count=data.l_follower_count
            data.relationships.is_following=data.relationships.l_is_following
            --ta_article_adp.notifyDataSetChanged()
            初始()
           else
          end
        end,
        function(code,content)
          提示("收藏失败："..code)
          data.follower_count=data.l_follower_count
          data.relationships.is_following=data.relationships.l_is_following
          --ta_article_adp.notifyDataSetChanged()
          初始()
        end)
      end
    end
  end

  初始()

  tarefresh1.setProgressViewOffset(true,dp2px(8), dp2px(48))
  tarefresh1.setColorSchemeColors({转0x(primaryc),转0x(primaryc)-0x9f000000})
  tarefresh1.setProgressBackgroundColorSchemeColor(转0x(backgroundc))
  tarefresh1.setSize(SwipeRefreshLayout.DEFAULT)

  tarefresh1.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      ta_article_page=1
      获取评论()
  end})

  function 获取评论()
    if tarefresh1_refreshing~=true then
      tarefresh1_refreshing=true
      tarefresh1.setRefreshing(true)
      if ta_article_page==1 then
        ta_article_nextpage=true
      end
      if ta_article_nextpage==false then
        tarefresh1_refreshing=false
        tarefresh1.setRefreshing(false)
        提示("没有更多了")
        return true
      end

      tanutai.getComments(data.article_id,ta_article_page,"-vote_count","user,voting",function(content)
        if ta_article_page==1 then
          ta_article_data={data}
        end
        for i=1,#content.data do
          ta_article_data[#ta_article_data+1]=content.data[i]
        end
        if ta_article_page~=1 then
          ta_article_adp.notifyItemRangeInserted(ta_article_adp.getItemCount(),#ta_article_data+1)
         else
          ta_article_adp.notifyDataSetChanged()
          if start_comment and first_enter
            tarv1_glm.scrollToPositionWithOffset(2,0);
          end
        end
        tarefresh1_refreshing=false
        tarefresh1.setRefreshing(false)
        ta_article_page=ta_article_page+1
        if content.pagination.next==nil then
          ta_article_nextpage=false
        end
        first_enter=false
      end,
      function(code,content)
        提示("获取评论失败："..code)
        tarefresh1_refreshing=false
        tarefresh1.setRefreshing(false)
        first_enter=false
      end)
     else
      提示("已经在加载了")
    end
  end

  ta_article_page=1
  获取评论()

  create_comment.onClick=function()
    activity.newActivity("tanutai/createcomment",{data.article_id})
  end
end

function onResult(name, ...)
  if name == "tanutai/createcomment" then
    newarticleticker = Ticker()
    newarticleticker.Period = 200
    newarticleticker.onTick = function()
      newarticleticker.stop()
      ta_article_page = 1
      获取评论()
    end
    newarticleticker.start()
  end
end

function 退出()
  activity.result({
    data.vote_up_count,
    data.vote_down_count,
    data.relationships.voting,
    data.follower_count,
    data.relationships.is_following,
  })
end

function onKeyDown(e)
  if e == 4 then
    退出()
    return true
  end
end

function 分屏()
  local function setWidth(v,n)
    linearParams = v.getLayoutParams()
    linearParams.width =n
    v.setLayoutParams(linearParams)
  end

  local function setHeight(v,n)
    linearParams = v.getLayoutParams()
    linearParams.height =n
    v.setLayoutParams(linearParams)
  end

  if activity.Height*0.9<activity.Width then
    --横屏
    setHeight(mActionBar,dp2px(48))
   else
    setHeight(mActionBar,dp2px(56))
  end
end

function onConfigurationChanged(newConfig)
  分屏()
end

分屏()
