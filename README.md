# JZGoodScrollView
/**</br>
 初始化轮播</br>

 @param frame            frame</br>
 @param urls             urls数组</br>
 @param placeHolderImage 占位图</br>

 @return JZGoodScrollView</br>
 */ </br></br>
-(instancetype)initWithFrame:(CGRect)frame urls:(NSArray *)urls placeHolderImage:(UIImage *)placeHolderImage;
</br></br>


/** * 是否显示pagecontrol  默认是yes */
@property(nonatomic,assign) BOOL pageShow;
</br></br>


/** * 当前分页控件小圆标颜色 默认 white */ </br></br>
@property(nonatomic,strong) UIColor * currentPageColor;

</br></br>
/** 其他分页控件小圆标颜色 默认 lightgray */</br></br>
@property(nonatomic,strong) UIColor * pageIndicatorTintColor;

</br></br>
/** * 是否自动滚动 默认为yes */</br></br>
@property(nonatomic,assign) BOOL autoScroll;</br></br>



/** * 自动滚动的时间间隔 默认3秒 */</br></br>
@property(nonatomic,assign) NSTimeInterval autoScrollTimeInterval;</br></br>



/** * 图片的Url数组 */</br></br>
@property(nonatomic,strong) NSArray * jzUrls;</br></br>



/** * 占位图 */</br></br>
@property(nonatomic,strong) UIImage * placeholderImage;</br></br>


/** * 开启定时器 */</br></br>
-(void)startTimer;</br></br>



/** * 暂时定时器 */</br></br>
-(void)stopTimer;</br></br>



/** * 彻底关闭定时器 在viewDidDisappear或viewWillDisappear 需要调用此方法 */</br></br>
-(void)invalidateTimer;</br></br>




/**</br>
 点击回调</br>

 @param didSelectedBlock 点击了图片 返回一个index</br>
 */</br></br>
-(void)goodScrollViewDidSelectedBlock:(JZGoodScrollViewClickBlock)didSelectedBlock;</br></br>



/**</br>
 停留回调</br>

 @param stopBlock 停留在哪张图片 返回一个index</br>
 */</br></br>
-(void)goodScrollViewStopBlock:(JZGoodScrollViewClickBlock)stopBlock;</br></br>
