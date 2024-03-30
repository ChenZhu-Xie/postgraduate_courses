<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="18008000">
	<Item Name="我的电脑" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="1. 主程序：输入 + 显示.vi" Type="VI" URL="../1. 主程序：输入 + 显示.vi"/>
		<Item Name="2. 初始化：光纤起点.vi" Type="VI" URL="../2. 初始化：光纤起点.vi"/>
		<Item Name="3. 绘制：管道分布 图.vi" Type="VI" URL="../3. 绘制：管道分布 图.vi"/>
		<Item Name="4. 生成：管道内的 光纤分布 数组.vi" Type="VI" URL="../4. 生成：管道内的 光纤分布 数组.vi"/>
		<Item Name="5. 绘制：管道内的 光纤分布 图.vi" Type="VI" URL="../5. 绘制：管道内的 光纤分布 图.vi"/>
		<Item Name="6.1. 通过匹配模式提取数字.vi" Type="VI" URL="../6.1. 通过匹配模式提取数字.vi"/>
		<Item Name="6. 读取：文件中的 传感数据 数组.vi" Type="VI" URL="../6. 读取：文件中的 传感数据 数组.vi"/>
		<Item Name="全局变量：数据点个数.vi" Type="VI" URL="../全局变量：数据点个数.vi"/>
		<Item Name="7. 绘制：管道内的 数据点分布 图.vi" Type="VI" URL="../7. 绘制：管道内的 数据点分布 图.vi"/>
		<Item Name="256×256的尘.ico" Type="Document" URL="../256×256的尘.ico"/>
		<Item Name="依赖关系" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Draw Multiple Lines.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Multiple Lines.vi"/>
				<Item Name="Set Pen State.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Set Pen State.vi"/>
				<Item Name="Draw Rectangle.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Rectangle.vi"/>
				<Item Name="Decrement Array Element.vim" Type="VI" URL="/&lt;vilib&gt;/Array/Decrement Array Element.vim"/>
				<Item Name="Increment Array Element.vim" Type="VI" URL="/&lt;vilib&gt;/Array/Increment Array Element.vim"/>
			</Item>
		</Item>
		<Item Name="程序生成规范" Type="Build">
			<Item Name="虚拟仪器2021课设_选题一_谢尘竹" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{FFFB6602-0762-4489-8F36-6CA2FF4B975B}</Property>
				<Property Name="App_INI_GUID" Type="Str">{E0E840A6-C3B1-4E41-A10E-56882A76C659}</Property>
				<Property Name="App_serverConfig.httpPort" Type="Int">8002</Property>
				<Property Name="Bld_autoIncrement" Type="Bool">true</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{0CAB6614-7445-44F2-84BB-2166C2B18EE4}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">虚拟仪器2021课设_选题一_谢尘竹</Property>
				<Property Name="Bld_defaultLanguage" Type="Str">ChineseS</Property>
				<Property Name="Bld_excludeInlineSubVIs" Type="Bool">true</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">..</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToProject</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{D4321809-649C-473F-A093-56374B7705A0}</Property>
				<Property Name="Bld_version.build" Type="Int">10</Property>
				<Property Name="Bld_version.major" Type="Int">1</Property>
				<Property Name="Destination[0].destName" Type="Str">虚拟仪器2021课设_选题一_谢尘竹.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../虚拟仪器2021课设_选题一_谢尘竹.exe</Property>
				<Property Name="Destination[0].path.type" Type="Str">relativeToProject</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">支持目录</Property>
				<Property Name="Destination[1].path" Type="Path">../data</Property>
				<Property Name="Destination[1].path.type" Type="Str">relativeToProject</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/我的电脑/256×256的尘.ico</Property>
				<Property Name="Source[0].itemID" Type="Str">{A0C93625-82EA-471A-B7CC-35B642EAE425}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/我的电脑/1. 主程序：输入 + 显示.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/我的电脑/2. 初始化：光纤起点.vi</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">VI</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/我的电脑/3. 绘制：管道分布 图.vi</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[3].type" Type="Str">VI</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/我的电脑/4. 生成：管道内的 光纤分布 数组.vi</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">VI</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/我的电脑/5. 绘制：管道内的 光纤分布 图.vi</Property>
				<Property Name="Source[5].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[5].type" Type="Str">VI</Property>
				<Property Name="Source[6].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[6].itemID" Type="Ref">/我的电脑/6.1. 通过匹配模式提取数字.vi</Property>
				<Property Name="Source[6].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[6].type" Type="Str">VI</Property>
				<Property Name="Source[7].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[7].itemID" Type="Ref">/我的电脑/6. 读取：文件中的 传感数据 数组.vi</Property>
				<Property Name="Source[7].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[7].type" Type="Str">VI</Property>
				<Property Name="Source[8].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[8].itemID" Type="Ref">/我的电脑/全局变量：数据点个数.vi</Property>
				<Property Name="Source[8].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[8].type" Type="Str">VI</Property>
				<Property Name="Source[9].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[9].itemID" Type="Ref">/我的电脑/7. 绘制：管道内的 数据点分布 图.vi</Property>
				<Property Name="Source[9].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[9].type" Type="Str">VI</Property>
				<Property Name="SourceCount" Type="Int">10</Property>
				<Property Name="TgtF_fileDescription" Type="Str">虚拟仪器2021课设_选题一_谢尘竹</Property>
				<Property Name="TgtF_internalName" Type="Str">虚拟仪器2021课设_选题一_谢尘竹</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">版权 2021 </Property>
				<Property Name="TgtF_productName" Type="Str">虚拟仪器2021课设_选题一_谢尘竹</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{068A8D26-D50D-4A03-A800-9770250459AF}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">虚拟仪器2021课设_选题一_谢尘竹.exe</Property>
				<Property Name="TgtF_versionIndependent" Type="Bool">true</Property>
			</Item>
		</Item>
	</Item>
</Project>
