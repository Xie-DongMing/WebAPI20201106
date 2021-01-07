<%@ Page Language="C#" AutoEventWireup="true" Inherits="KZS.KMESWeb.WebUI.Helper.BasePage" %>

<!DOCTYPE html>
<html>
<head>
    <title>网工厂 - 联接全球制造基地，打造实时的、虚拟的数字化工厂</title>
    <meta http-equiv="X-UA-Compatible" content="IE=9"></meta>
    <link rel="stylesheet" type="text/css" href="../jquery-easyui/themes/default/kzs_eui.css" />
    <link rel="stylesheet" type="text/css" href="../jquery-easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="../jquery-easyui/demo/demo.css" />
    <link rel="stylesheet" type="text/css" href="../Skin/EUIStyle.css" />
    <script type="text/javascript" src="../jquery-easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Skin/JS/dropdownlist.js"></script>
    <script type="text/javascript" src="../Skin/JS/pagecommon.js"></script>
    <script type="text/javascript" src="../LabelPrint/print_component.js"></script>
    <script type="text/javascript" src="../jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script>
        __PageRootRelativePath = "../";
    </script>
</head>
<body style="width: 100%; margin: 0px; padding: 0px;" onload="PageOnLoad()">
    <form runat="server">
    </form>
    <div>
        <div id="tabTitle" data-options="region:'north',title:'杂项入库单打印'" style="overflow: hidden;
            background: #F4F4F4;" iconcls="icon-ok">
            <div id="tabquery" style="padding: 7px;">
                <table width="99%" id="tableMo">
                    <tr>
                        <td width="85%">
                        <table width="100%">
                        <tr>
                        <td>
                        <a id="A4" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="AddNewDocBill();">新增单据</a>
                        <a id="A3" class="easyui-linkbutton" iconcls="icon-cancel" onclick="CancelUpload();">单据取消</a>
                        <a id="btnClear" class="easyui-linkbutton" iconcls="icon-reload" onclick="ClearPage();">清空</a>
                        <a id="A2" class="easyui-linkbutton" iconcls="icon-ok" onclick="UploadToEBS();"  style=" display: none">事务提交</a>
                        <a id="A6" class="easyui-linkbutton" iconcls="icon-no" data-options="disabled:true" onclick="CloseTrans();">单据关闭</a>
                        <%--<a id="A5" class="easyui-linkbutton" iconcls="icon-edit" onclick="CopyBill();">复制单据</a>--%>
                        <a id="A1" class="easyui-linkbutton" iconcls="icon-save" onclick="SaveInvMakeBill();">保存单据</a>
                       <%-- <a id="btnImport" class="easyui-linkbutton" iconcls="icon-add" onclick="ImportData();">批量导入</a>--%>
						<input id="txtDocBillCode1" mappingproperty="BillNo"  class="easyui-validatebox textbox"  ></input>
                        <a href="javascript:void(0)" id="btnSearch" class="easyui-linkbutton" iconcls="icon-search"
                        onclick="queryDataNew(1,0);">查询</a>
                        </td>
                        </tr>
                        </table>
                            <table width="100%">
                                <tr class="querylists" style="height: 20px">
                                    <td class="fieldName" align="right" nowrap>
                                        领料单号：
                                    </td>
                                    <td align="left">
                                        <input id="txtCreateFromIssueBill" class="easyui-validatebox textbox"  ></input>
                                        <a href="javascript:void(0)" id="btnCreateFromIssueBill" class="easyui-linkbutton" iconcls="icon-search"
                                onclick="CreateFromIssueBill()">领料单加载</a>
                                    </td>
									<td class="fieldName" align="right" nowrap>
                                        领料单号：
                                    </td>
                                    <td align="left">
                                        <input id="txtCreateFromIssueBillnew"    style="  background:#FFFFE0;" mappingproperty="EAttribute15"  disabled="true" class="easyui-validatebox textbox"  ></input>
                                    </td>
                                </tr>
                                <tr class="querylists" style="height: 20px">
                                    <td class="fieldName" align="right" nowrap>
                                        单据编号：
                                    </td>
                                    <td align="left">
                                        <input id="txtDocBillCode" mappingproperty="BillNo" disabled="true" style="background:#FFFFE0;"  class="easyui-validatebox textbox"  ></input>
                                        <input id="txtCurrentOrgID" class="easyui-textbox"  value="<%= OrgID%>" type="hidden" /></input>
                                        <input id="txtInstID" class="easyui-textbox"  type="hidden" /></input>
                                    </td>
                                    <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *单据日期：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <input id="txtDocBillDate" mappingproperty="PurchaseDate" class="easyui-datebox textbox"></input>
                                    </td>
                                    <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *制单人：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <input id="txtMakeBillUser" mappingproperty="BillNo"  class="easyui-validatebox textbox" ></input>
                                        <input id="txtMakeBillUserBySys" class="easyui-textbox"  value="<%= GetUserCode()%>" type="hidden" /></input>
                                    </td>
                                    </tr>
                                    <tr>
                                        <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *事业部：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <select id="cbxBusinessUnit" mappingproperty="EAttribute10" style="width:140px;" 
                                            class="easyui-combobox require" data-options="textField:'EAttribute10',valueField:'EAttribute9'" disabled="true"></select>
                                        <script language="javascript" type ="text/javascript">
                                            //NAttribute1：1代表视图为v_OrgBusiness，2代表v_OrgDepartment
                                            //                                            loadListItemJson('cbxBusinessUnit', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=1', '{EAttribute10}', '{EAttribute9}');
//                                            function LoadComboBox_cbxBusinessUnit(filter) {
//                                                loadComboBoxData('cbxBusinessUnit', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=1', filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
//                                            }
//                                            $(document).ready(function () {
//                                                LoadComboBox_cbxBusinessUnit("");
//                                                $("#cbxBusinessUnit").combobox({
//                                                    onSelect: function (rec) {
//                                                        LoadComboBox_cbxInvDepartment("EAttribute8=" + rec.EAttribute9);
//                                                        //                                                    LoadComboBox_cbxInInv();
//                                                    }
//                                                });
                                            //                                            });
                                            clearOptions('cbxBusinessUnit');
                                            addListItem('cbxBusinessUnit', '不区分', '0');
                                        </script>
                                        </td>
                                        <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *申请日期：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <input id="txtApplyDate" mappingproperty="ApplyDate" class="easyui-datebox textbox"></input>
                                    </td>
                                        <td class="fieldName" align="right" nowrap>
                                        申请人：
                                    </td>
                                    <td align="left">
                                        <input id="txtPersonApply" mappingproperty="PersonApply"  class="easyui-validatebox textbox"  ></input>
                                    </td>
                                    
                                </tr>
                                <tr>
                                        <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *入库部门：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <select id="cbxInvDepartment" mappingproperty="EAttribute2" style="width:140px;" class="easyui-combobox require" data-options="textField:'EAttribute10',valueField:'EAttribute9',panelWidth: 260" disabled ="true"></select>
                                        <script language=javascript>
                                            //NAttribute1：1代表视图为v_OrgBusiness，2代表v_OrgDepartment
//                                            loadListItemJson('cbxInvDepartment', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=2', '{EAttribute10}', '{OrgID}');

//                                            function LoadComboBox_cbxInvDepartment(filter) {
//                                                loadComboBoxData('cbxInvDepartment', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=2&OrgID=' + $("#txtCurrentOrgID").val(), filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
//                                            }
//                                            $(document).ready(function () {
//                                                LoadComboBox_cbxInvDepartment("");

                                            //                                            });
                                            clearOptions('cbxInvDepartment');
                                            addListItem('cbxInvDepartment', '不区分', '0');
                                         </script>
                                        </td>
                                        <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *事务类型：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <select id="cbxGenericDispositions" mappingproperty="EAttribute2"  color="red" style="width:140px;" class="easyui-combobox require" data-options="textField:'EAttribute10',valueField:'EAttribute9'" disabled="true"></select>
                                        <script language=javascript>
                                            clearOptions('cbxGenericDispositions');
                                            addListItem('cbxGenericDispositions', '受托方入库', '320');

                                           //                                            loadListItemJson('cbxGenericDispositions', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=3&OrgID=' + $("#txtCurrentOrgID").val(), '{EAttribute10}', '{EAttribute9}');
/*function LoadComboBox_cbxGenericDispositions(filter) {
                                                loadComboBoxData('cbxGenericDispositions', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=3&NAttribute2=27&OrgID=' + $("#txtCurrentOrgID").val(), filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
                                            }
                                            $(document).ready(function () {
                                                LoadComboBox_cbxGenericDispositions("");
                                                $("#cbxGenericDispositions").combobox({
                                                    onSelect: function (rec) {
                                                        LoadComboBox_cbxOutInv("EAttribute8=" + rec.EAttribute10);
                                                        // LoadComboBox_cbxInInv();
                                                    }
                                                });
                                            });*/
    </script>
                                        </td>
                                        <td class="fieldName" align="right" nowrap>
                                        <font color="red">
                                        *仓库：
                                        </font>
                                    </td>
                                    <td align="left">
                                        <select id="cbxOutInv" mappingproperty="EAttribute2" style="width:140px;" class="easyui-combobox require" data-options="textField:'EAttribute10',valueField:'EAttribute9',panelWidth: 260"></select>
                                        <script language="javascript">

//                                            clearOptions('cbxOutInv');
//                                            //                                            addListItem('cbxItemType', '', '');
//                                            loadListItemJson('cbxOutInv', 'BLLInventory/QueryEntityInventory.aspx?GroupBy=InvCode&OrgID=' + $("#txtCurrentOrgID").val(), '{InvCode}--{InvDesc}', 'InvCode');

//                                            $("#cbxOutInv").val(1);
                                            function LoadComboBox_cbxOutInv(filter) {

//                                                loadComboBoxData('cbxOutInv', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=30&EAttribute8=客退返修入库&OrgID=' + $("#txtCurrentOrgID").val(), filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
                                                loadComboBoxData('cbxOutInv', 'BLLInventory/QueryEntityInventoryPower.aspx?NAttribute5=1&EAttribute8=客退返修入库&OrgID=' + $("#txtCurrentOrgID").val(), filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
                                            }
                                            $(document).ready(function () {
                                                LoadComboBox_cbxOutInv("");

                                            });
    
    </script>

                                         </td>
                                        
                                </tr>
                                <tr>
                                <td class="fieldName" align="right" nowrap>
                                客户名称：
                                    </td>
                                    <td align="left">
                                        <select id="cbxCustomerName" mappingproperty="EAttribute2" style="width:140px;" class="easyui-combobox require" data-options="textField:'EAttribute9',valueField:'EAttribute8',panelWidth: 260"></select>
                                        <script language=javascript>

                                            //                                            loadListItemJson('cbxGenericDispositions', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=3&OrgID=' + $("#txtCurrentOrgID").val(), '{EAttribute10}', '{EAttribute9}');
                                            function LoadComboBox_cbxCustomerName(filter) {
                                                loadComboBoxData('cbxCustomerName', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=26', filter, 'EAttribute9', 'EAttribute8', true, "--请选择--");
                                            }
                                            $(document).ready(function () {
                                                LoadComboBox_cbxCustomerName("");
                                            });
    </script>
                                        </td>
                                        <td align="right" nowrap>
                是否报检：
            </td>
            <td align="left" colspan="3">
                <table>
                    <tr>
                    <td align="left">
                        <td><input id="chkIsIQCSummit" type="checkbox" name="chkIsIQCSummit" value="0" />
                        <a href="javascript:void(0)" id="btnIQCSummit" data-options="disabled:true" class="easyui-linkbutton" iconcls="icon-tip"
                                onclick="SummitToIQC()">报检</a>
                        <script language=javascript>
                            $(document).ready(function () {
                                $("#chkIsIQCSummit").change(function () {
                                    if ($('#chkIsIQCSummit').is(':checked')) {
                                        $("#btnIQCSummit").linkbutton("enable");
                                    }
                                    else {
                                        $("#btnIQCSummit").linkbutton("disable");
                                    }
                                });
                            });
                        </script>
                        </td>
                        
                    </td>
                    </tr>
                </table>
            </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                </table>
                <table>
                <td class="fieldName" align="right" nowrap>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                         事务原因：
                                    </td>
                                    <td align="left">
                                        <select id="cbxInvTransReason" mappingproperty="EAttribute2" style="width:140px;" class="easyui-combobox require" data-options="textField:'EAttribute10',valueField:'EAttribute9',"></select>
                                        <script language=javascript>

//                                            loadListItemJson('cbxInvTransReason', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=4', '{EAttribute10}', '{OrgID}');
                                            function LoadComboBox_cbxInvTransReason(filter) {
                                                loadComboBoxData('cbxInvTransReason', 'BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=4', filter, 'EAttribute10', 'EAttribute9', true, "--请选择--");
                                            }
                                            $(document).ready(function () {
                                                LoadComboBox_cbxInvTransReason("");

                                            });
    </script>
                                        </td>
                                <td class="fieldName" align="right" nowrap>
                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        备注：
                                    </td>
                                    <td align="left">
                                        <input id="txtMemo" mappingproperty="Memo" style="width:420px;" 
                                            class="easyui-validatebox textbox"  ></input>
                                    </td>
                </table>
            </div>
        </div>
        <fieldset style="background: #F4F4F4;">
            <legend>杂项入库单清单</legend>
            <div id="gridDetailToolBar">
            <!-- <a id="btnCancel" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="RemoveDetail();">删除</a>
            <a id="btnAdd" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="AddToDetail();">添加</a> -->
            <a id="btnAddLotNo" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:false" onclick="AddLotNo();">添加批次</a>
            <!-- <a id="btnAddFastenLotNo" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:false" onclick="AddFastenLotNo();">生成固定批次</a> -->
            <%--<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:false" onclick="btnEdit();" >编辑</a>--%>
            
            </div>
            <div data-options="region:'center',split:false,title:'杂项入库单清单'">
                <table id="gridDetail" class="easyui-datagrid" style="height: 320px;" >
                </table>
            </div>
            
        </fieldset>
        <div data-options="region:'south',title:'杂项入库单信息'" style="overflow: hidden;
            background: #F4F4F4;">
            <div>
                <table width="99%" id="tableEdit">
                    <tr>
                        <td width="85%">
                            <table width="100%">
                                <tr class="querylists">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <%--<td align="center"><a id="A1" class="easyui-linkbutton" iconcls="icon-save" onclick="SaveInvMakeBill();">事务提交</a></td>--%>
                                    <td align="center">
                                    
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><hr /></td>
                    </tr>
                    <tr>
                        <td width="85%">
                            <table width="100%">
                                <tr class="querylists">
                                    <td class="fieldName" align="right" nowrap>
                                        打印机：
                                    </td>
                                    <td align="left">
                                        <select id="drpPrinterList" style="width: 200px;">
                                        </select>
                                        <script language="javascript">

                                            LabelPrint_GetLocalPrinter_SelectDefault('drpPrinterList');
                                            addListItem('drpPrinterList', "Microsoft XPS Document Writer", "Microsoft XPS Document Writer");

                                            addItemGroup('drpPrinterList', "网络打印机", "server");
                                            loadListItem('drpPrinterList', 'LabelPrint/QueryNetPrinterByWorkLoc.aspx', 'PrinterName', 'PrinterName');
                                    </script>
                                    </td>
                                    <td>
                                        <a id="btnLabelPrint" class="easyui-linkbutton" iconcls="icon-print" onclick="GoToPrintLabel();">物料批次标签打印</a>
                                        <a id="btnPrint" class="easyui-linkbutton" iconcls="icon-print" onclick="PrintButtonClick_btnPrint();">杂项入库单打印</a>
                                        <%--<a id="btnLabelPrint" class="easyui-linkbutton" iconcls="icon-print" onclick="GoToPrintLabel();">标签打印</a>--%>
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function CreateFromIssueBill() {
            if ($("#txtCreateFromIssueBill").val() == "") {
                $.messager.alert('提醒', '请输入领料单号！', 'info');
                return;
            }
            $("#txtDocBillCode").val("");
            $("#txtDocBillCode1").val("");
            var strIssueBillNo = $("#txtCreateFromIssueBill").val();
            var zastatus = "";
            zastatus = ifdoissue(strIssueBillNo);
            if (zastatus != "") {
                $.messager.alert('提醒', '已经生成过入库单，请确认！！单号' + zastatus, 'info');
                return;
            }
            $.messager.progress({ title: '请稍等', msg: '数据加载中...' });
            // 查询领料单
            var postArgs = new Object();
            var sUrl = "";
            postArgs["OrgID"] = "0";
            if (strIssueBillNo.indexOf("DBD") != -1) {
                postArgs["EAttribute15"] = "DBD";
            }
            else if (strIssueBillNo.indexOf("ZFD") != -1) {
                postArgs["EAttribute15"] = "ZFD";
            }
            postArgs["TlblsCode"] = strIssueBillNo;
            sUrl = "../BLLGetBill/QueryEntitySumGetBill.aspx";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                success: function (json) {
                    if (json == undefined || json.result == "fail") {
                        $.messager.progress('close');
                        $.messager.alert('提醒', json.errormsg, 'info');
                        return;
                    }
                    if (json.rows == undefined || json.rows.length == 0) {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '没有找到此领料单号', 'info');
                        return;
                    }
                    if (json.rows.length > 1) {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '此领料单号存在多个来源货位', 'info');
                        return;
                    }
                    var objRow = json.rows[0];
                    if (objRow["Status"] == "cancel") {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '此领料单已取消', 'info');
                        return;
                    }
                    if (objRow["Status"] != "close" && objRow["Status"] != "Close") {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '此领料单尚未接收', 'info');
                        return;
                    }
                    if (objRow["BillType"] != "MO_PULL") {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '此领料单不是拉式领料单', 'info');
                        return;
                    }
                    if (strIssueBillNo.indexOf("DBD") == -1 || strIssueBillNo.indexOf("ZFD") == -1) {
                        // 检查是否有做过交易
                        if (CheckIssueBillHasTrans(objRow["OrgID"], strIssueBillNo) == false) {
                            $.messager.progress('close');
                            $.messager.alert('提醒', '此领料单没有做发货事务，不允许使用', 'info');
                            return;
                        }
                    }

                    // 检查物料在当前组织是否存在
                    var ItemSummery = "";
                    ItemSummery = CheckTransItem($("#txtCurrentOrgID").val(),strIssueBillNo);
                    if(ItemSummery != undefined && ItemSummery != ""){
                        $.messager.progress('close');
                        $.messager.alert('提醒', '物料号[' + ItemSummery + ']在当前组织不存在,请在EBS检查物料状态!', 'info');
                        return;
                    }

                    // 查询单据明细
                    var postArgs = new Object();
                    //postArgs["OrgID"] = objRow["OrgID"];

                    var orgId = "";
                    orgId = GETORGID(objRow["ReceiveLocCode"], objRow["OrgID"], objRow["ReceiveInvCode"]);

                    if (orgId != $("#txtCurrentOrgID").val()) {
                        $.messager.progress('close');
                        $.messager.alert('提醒', '此领料单对应入库组织错误，请确认', 'info');
                        return;
                    }
                    postArgs["OrgID"] = "0";
                    if (strIssueBillNo.indexOf("DBD") != -1) {
                        postArgs["EAttribute15"] = "DBD";
                    }
                    else if (strIssueBillNo.indexOf("ZFD") != -1) {
                        postArgs["EAttribute15"] = "ZFD";
                    }
                    postArgs["TlblsCode"] = strIssueBillNo;
                    var sUrl = "../BLLGetBill/QueryEntitySumGetBillSummary.aspx";
                    $.ajax({
                        type: "post",
                        url: sUrl,
                        data: postArgs,
                        dataType: "json",
                        success: function (json) {
                            if (json == undefined || json.result == "fail") {
                                $.messager.progress('close');
                                $.messager.alert('提醒', json.errormsg, 'info');
                                return;
                            }
                            $("#txtCreateFromIssueBillnew").val(strIssueBillNo);


                            var item = $('#gridDetail').datagrid('getRows');  //add by zhangpeng
                            if (item) {
                                for (var i = item.length - 1; i >= 0; i--) {
                                    var index = $('#gridDetail').datagrid('getRowIndex', item[i]);
                                    $('#gridDetail').datagrid('deleteRow', index);
                                }
                            }
                            var objRows = json.rows;
                            for (var i = 0; objRows != undefined && i < objRows.length; i++) {
                                var objGridRow = new Object();
                                objGridRow["ItemName"] = objRows[i]["ItemName"];
                                objGridRow["EAttribute3"] = objRows[i]["ItemDesc"];
                                objGridRow["Qty"] = objRows[i]["SuggestQty"];
                                objGridRow["LotNo"] = objRows[i]["EAttribute1"];
                                $("#gridDetail").datagrid("appendRow", objGridRow);
                            }
                            $.messager.progress('close');
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.progress('close');
                            $("#winSubQuery").window({
                                title: textStatus + ':' + XMLHttpRequest.statusText,
                                closed: true,
                                iconCls: 'icon-cancel',
                                content: XMLHttpRequest.responseText
                            });
                            $("#winSubQuery").window("open");
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.progress('close');
                    $("#winSubQuery").window({
                        title: textStatus + ':' + XMLHttpRequest.statusText,
                        closed: true,
                        iconCls: 'icon-cancel',
                        content: XMLHttpRequest.responseText
                    });
                    $("#winSubQuery").window("open");
                }
            });
        }
		
		
		//获取location表的EAttribute1
		function GETORGID(loccode,orgid,invcode){
		             var  postArgs=new Object();
					 postArgs["LocCode"]=loccode;
					 postArgs["OrgID"] = orgid;
					 postArgs["InvCode"] = invcode;
					 var orgid="";
					 var url1="../BLLInventory/QueryEntityInvLocation.aspx";
					 $.ajax({
					 type:"post",
					 url:url1,
					 dataType:"json",
					 data:postArgs,
					 async:false,
					 success:function(json){
					  if (json.total>0&&json.rows[0].EAttribute1!=""){
                              	orgid=json.rows[0].EAttribute1;
                                 }		
                               }								 
                         
					  });
					  return orgid;
					  }
		//校验
		 function ifdoissue(BillNo) {
            var result="";
            var post = new Object();
            post["BillNo"] = BillNo;
            var url = "../BLLDeliveryOut/ifdoissue.aspx"
            $.ajax({
                type: "post",
                url: url,
                data: post,
                dataType: "json", 
                async: false,
                success: function (json) {
                    if (json.total > 0)
                        result = json.rows[0].billno;      
                }
                  
            });
            return result;
         }
        function CheckIssueBillHasTrans(orgId, strBillNo) {
            var postArgs = new Object();
            var hasTrans = 0; //是否已经做了事务处理
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=21&OrgID=" + orgId + "&BillNo=" + strBillNo;
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        hasTrans = json.rows[0].NAttribute2;
                    }
                }
            });
            return hasTrans;
        }
        function CheckTransItem(orgId, strBillNo) {
            var hasItem = "";
            var postArgs = new Object();
            postArgs["OrgID"] = $("#txtCurrentOrgID").val();
            postArgs["EAttribute14"] = "CheckItem";
            if (strBillNo.indexOf("DBD") != -1) {
                postArgs["EAttribute15"] = "DBD";
            }
            else if (strBillNo.indexOf("ZFD") != -1) {
                postArgs["EAttribute15"] = "ZFD";
            }
            postArgs["TlblsCode"] = strBillNo;
            var sUrl = "../BLLGetBill/QueryEntitySumGetBill.aspx";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        for (var i = 0; i < json.rows.length; i++) {
                            hasItem = hasItem + json.rows[i].EAttribute1 + ",";
                        }
//                        hasItem = json.rows[0].EAttribute1;
                    }
                }
            });
            return hasItem;
        }
        function checkIsInDocbill(billno)
		{
		  var url="BLLDocBill/checkIsInDocbill.aspx";
		  var post=new Object();
		  var hasTrans="";
		  post["BillNo"]=billno;
		   $.ajax({
                type: "post",
                url: url,
                data:post,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        hasTrans = json.rows[0].EAttribute15;
                    }
                }
            });
            return hasTrans;
		}
        var IsClickQueryBtn = 0; //是否点击查询按钮
        function queryDataNew(page, rows) {
            if ($("#txtDocBillCode1").val() == "") {
                $.messager.alert('提醒', '请输入单据编号！', 'info');
                return;
            }
			
            else {
                var docBillStatus = "Initial";
                var postArgs = new Object();
                postArgs["BillNo"] = $("#txtDocBillCode1").val();
				//var strIssueBillNo = $("#txtCreateFromIssueBill").val();
				//var hasval="";
               // hasval=checkIsInDocbill(billno);
				// if(hasval=strIssueBillNo)
				//  {
				// $.messager.alert('提醒', '一个出货单只能生成一次！', 'info');
				// }
                var Url = "../BLLDocBill/QueryEntityDocBill_New.aspx?NAttribute1=1";
                $.post(Url, postArgs, function (xml, status) {
                    if (status == "success") {
                        var vendorJson = $.parseJSON(xml);
                        if (vendorJson.rows.length > 0) {
                            //                            $("#txtVendorID").val(vendorJson.rows[0].VendorID);
                            //$('#gridDetail').datagrid('loadData', vendorJson); //绑定数据
                            $("#cbxOutInv").combobox('setValue', vendorJson.rows[0]["RcvInvCode"]).combobox('setText', vendorJson.rows[0]["EAttribute5"]);
                            $('#txtDocBillDate').datebox('setValue', vendorJson.rows[0]["CreateDate"].replace("/", "-").replace("/", "-"));
                            $("#txtMakeBillUser").val(vendorJson.rows[0]["CreateUser"]);
                            $('#txtApplyDate').datebox('setValue', vendorJson.rows[0]["DAttribute1"].replace("/", "-").replace("/", "-")); //vendorJson.rows[0]["DAttribute1"]);//.val(vendorJson.rows[0]["DAttribute1"]);
                            $("#txtMemo").val(vendorJson.rows[0]["Memo"]);
                            $("#txtInstID").val(vendorJson.rows[0]["InstID"]);
                            $("#cbxBusinessUnit").combobox('setValue', vendorJson.rows[0]["EAttribute7"]).combobox('setText', vendorJson.rows[0]["EAttribute1"]);
                            $("#cbxInvDepartment").combobox('setValue', vendorJson.rows[0]["EAttribute8"]).combobox('setText', vendorJson.rows[0]["EAttribute2"]);
                            $("#cbxInvTransReason").combobox('setValue', vendorJson.rows[0]["EAttribute9"]).combobox('setText', vendorJson.rows[0]["EAttribute3"]);
							$("#txtDocBillCode").val(vendorJson.rows[0]["BillNo"]);
							$("#txtCreateFromIssueBill").val(vendorJson.rows[0]["EAttribute15"]);
							$("#txtCreateFromIssueBillnew").val(vendorJson.rows[0]["EAttribute15"]);
                            $("#cbxGenericDispositions").combobox('setValue', vendorJson.rows[0]["EAttribute10"]).combobox('setText', vendorJson.rows[0]["EAttribute10"]);
                            $("#txtPersonApply").val(vendorJson.rows[0]["EAttribute6"]);
                            docBillStatus = vendorJson.rows[0]["Status"];
                            $("#cbxCustomerName").combobox('setValue', vendorJson.rows[0]["CustomerCode"]).combobox('setText', vendorJson.rows[0]["EAttribute13"]);
                            vendorJson.rows[0]["NAttribute5"] == "1" ? $("#chkIsIQCSummit").attr("checked", true) : $("#chkIsIQCSummit").attr("checked", false)
                            //                            if (docBillStatus != "lm_initial") 
                            if (VerificateHasTrans($("#txtDocBillCode").val()) > 0) {
                                
                                //$("#A1").linkbutton("disable");
                                //$("#A2").linkbutton("disable");
                                $("#A3").linkbutton("disable");
                                $("#btnCancel").linkbutton("disable");
                                $("#btnAdd").linkbutton("disable");
                                $("#btnAddLotNo").linkbutton("disable");
                                $("#btnIQCSummit").linkbutton("disable");
                            }
                            else {
                                $("#A1").linkbutton("enable");
                                $("#A2").linkbutton("enable");
                                $("#A3").linkbutton("enable");
                                $("#btnCancel").linkbutton("enable");
                                $("#btnAdd").linkbutton("enable");
                                $("#btnAddLotNo").linkbutton("enable");
                                $("#btnIQCSummit").linkbutton("enable");
                            }
                        }
                        else {
                            $.messager.alert('提醒', '该单据编号无数据！', 'info');
                            return;
                        }
                    }
                });

                var postDtlArgs = new Object();
                postDtlArgs["BillNo"] = $("#txtDocBillCode1").val();
                var sUrl = "../BLLDocBillDetail/QueryEntityDocBillDetail_New.aspx?NAttribute1=1";
                $.post(sUrl, postDtlArgs, function (xml, status) {
                    if (status == "success") {
                        var vendorDtlJson = $.parseJSON(xml);
                        if (vendorDtlJson.rows.length > 0) {
                            $('#gridDetail').datagrid('loadData', vendorDtlJson); //绑定数据
                        }
                        else {
                            $('#gridDetail').datagrid('loadData', vendorDtlJson); //绑定数据
                            $.messager.alert('提醒', '该单据编号无明细数据！', 'info');
                            return;
                        }
                    }
                });
            }
        }
        function queryData(page, rows) {
            if ($("#txtDocBillCode1").val() == "") {
                $.messager.alert('提醒', '请输入单据编号！', 'info');
                return;
            }
            else {
                IsClickQueryBtn = 1;
                //            if ($("#txtInventory").val() == "") {
                //                $.messager.alert("操作提示", "请输入仓库号", "error");
                //                return;
                //            }
                //            else {
                var docBillStatus = "Initial";
                var postArgs = new Object();
                postArgs["BillNo"] = $("#txtDocBillCode1").val();
                var sUrl = "../BLLDocBillDetail/QueryEntityDocBillDetailExtend.aspx";
                $.post(sUrl, postArgs, function (xml, status) {
                    if (status == "success") {
                        var vendorJson = $.parseJSON(xml);
                        if (vendorJson.rows.length > 0) {
                            //                            $("#txtVendorID").val(vendorJson.rows[0].VendorID);
                            $('#gridDetail').datagrid('loadData', vendorJson); //绑定数据
                            $("#cbxOutInv").combobox('setValue', vendorJson.rows[0]["RcvInvCode"]).combobox('setText', vendorJson.rows[0]["EAttribute8"]);
                            //                        $("#cbxInInv").combobox('setValue', vendorJson.rows[0]["RcvInvCode"]).combobox('setText', vendorJson.rows[0]["EAttribute8"]);
                            //                            $("#txtDocBillDate").val(vendorJson.rows[0]["CreateDate"]);
                            $('#txtDocBillDate').datebox('setValue', vendorJson.rows[0]["CreateDate"].replace("/", "-").replace("/", "-"));
                            $("#txtMakeBillUser").val(vendorJson.rows[0]["CreateUser"]);
                            $('#txtApplyDate').datebox('setValue', vendorJson.rows[0]["DAttribute1"].replace("/", "-").replace("/", "-")); //vendorJson.rows[0]["DAttribute1"]);//.val(vendorJson.rows[0]["DAttribute1"]);
                            $("#txtMemo").val(vendorJson.rows[0]["Memo"]);
                            $("#txtInstID").val(vendorJson.rows[0]["EAttribute9"]);
                            $("#cbxBusinessUnit").combobox('setValue', vendorJson.rows[0]["EAttribute11"]).combobox('setText', vendorJson.rows[0]["EAttribute15"]);
                            $("#cbxInvDepartment").combobox('setValue', vendorJson.rows[0]["EAttribute12"]).combobox('setText', vendorJson.rows[0]["EAttribute1"]);
                            $("#cbxInvTransReason").combobox('setValue', vendorJson.rows[0]["EAttribute13"]).combobox('setText', vendorJson.rows[0]["EAttribute2"]);
                            $("#cbxGenericDispositions").combobox('setValue', vendorJson.rows[0]["EAttribute14"]).combobox('setText', vendorJson.rows[0]["EAttribute14"]);
                            $("#txtPersonApply").val(vendorJson.rows[0]["EAttribute6"]);
                            docBillStatus = vendorJson.rows[0]["Status"];
                            //                            if (docBillStatus != "lm_initial") 
                            if (VerificateHasTrans($("#txtDocBillCode").val()) > 0) {
                                $("#A1").linkbutton("disable");
                                $("#A2").linkbutton("disable");
                                $("#A3").linkbutton("disable");
                                $("#btnCancel").linkbutton("disable");
                                $("#btnAdd").linkbutton("disable");
                            }
                            else {
                                $("#A1").linkbutton("enable");
                                $("#A2").linkbutton("enable");
                                $("#A3").linkbutton("enable");
                                $("#btnCancel").linkbutton("enable");
                                $("#btnAdd").linkbutton("enable");
                            }
                        }
                        else {
                            $.messager.alert('提醒', '该单据编号无数据！', 'info');
                            return;
                        }
                    }
                });

                _queryPage = page;
                _queryRows = rows;
            }
            //            }
        }

        function CopyBill() {
            var rows = $('#gridDetail').datagrid('getRows');
            if (rows.length <= 0) {
                $.messager.alert('提醒', '没有可复制的数据！', 'info');
                return;
            }
            $("#A1").linkbutton("enable");
            $("#A2").linkbutton("enable");
            $("#A3").linkbutton("enable");
            $("#A4").linkbutton("enable");
            $("#A5").linkbutton("enable");
            $("#A6").linkbutton("enable");
            $("#btnCancel").linkbutton("enable");
            $("#btnAdd").linkbutton("enable");
            $("#btnAddLotNo").linkbutton("enable");
            $("#btnIQCSummit").linkbutton("enable");
            $("#txtDocBillCode").val('');
            $("#txtDocBillDate").datebox("setValue", getDate());
            $("#txtApplyDate").datebox("setValue", getDate());
            isGetLotNo = 0;

            //复制时清空批次
            for (var i = 0; i < rows.length; i++) {
                iRowIndex = i;
                endEditing();
                //                strLotNo = $(xml).find("lotno").text();
                $('#gridDetail').datagrid('beginEdit', iRowIndex);
                var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'LotNo' });
                edt.target.val("");
                $('#gridDetail').datagrid('endEdit', iRowIndex);
                //endEditing();
            }
        }

        function BindInInvCombox() {
            $("#txtDocBillCode").val($("#cbxOutInv").combobox(getText));
        }

        function ShowSegName()
        {
            var postArgs = new Object();
            postArgs["SegName"] = $("#txtSegCodeQuery").val();
            var sUrl = "../BLLSegment/QueryEntitySegment.aspx";
            var vSuccess = "";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                success: function (json)
                {
                    if (json.total > 0)
                    {
                        $("#txtSegNameQuery").val(json.rows[0].SegDesc);
                    }
                }
            });
        }

        function AfterGridLoadData()
        {
            var currentEditIndex = -1;
            $.extend($.fn.datagrid.methods, {
            editCell: function (jq, param) {
                var edt = $(this).datagrid('getEditor', { index: param.index, field: param.field });
                edt.target.keydown(keyParam, function () { 
                                    });
                                } 
                            });
    }


    function AddNewDocBill() {
        $("#txtDocBillCode").val("");
        //        $('#gridDetail').remove();
        $('#gridDetail').datagrid('loadData', { total: 0, rows: [] });
        $("#txtMakeBillUser").val($("#txtMakeBillUserBySys").val());
        $("#txtDocBillDate").datebox("setValue", getDate());
        $("#txtApplyDate").datebox("setValue", getDate());
        $("#txtDocBillCode").val('');
        $("#txtOrderNo").val('');
        $("#txtMoMitemCode").val('');
        $("#txtMoMitemName").val('');
        $("#txtOrderQty").val('');
        
        //        $("#cbxOutOrg").combobox('setValue', '');
        $("#cbxOutInv").combobox("setValue", '');
//        $("#cbxInInv").combobox("setValue", '');
        $("#cbxBusinessUnit").combobox("setValue", '0').combobox("setText",'不区分');
        $("#cbxInvDepartment").combobox("setValue", '0').combobox("setText", '不区分');
        //$("#cbxGenericDispositions").combobox("setValue", '320').combobox("setText", '受托方入库');
        $("#cbxInvTransReason").combobox("setValue", '');
        //            $("#txtPersonApply").val('');
        $("#txtMemo").val('');
        $("#txtPersonApply").val('');

        $("#A1").linkbutton("enable");
        //$("#A2").linkbutton("enable");
        $("#A3").linkbutton("enable");
        $("#A4").linkbutton("enable");
        $("#btnCancel").linkbutton("enable");
        $("#btnAdd").linkbutton("enable");
        $("#btnAddLotNo").linkbutton("enable");
        $("#btnIQCSummit").linkbutton("enable");
        isGetLotNo = 0;
    }
//        var editRow=undefined;
        function AddToDetail() {
            
            var objRow = new Object();
            var rowIndex;
            $('#gridDetail').datagrid("appendRow", objRow);
            $('#gridDetail').datagrid('beginEdit', rowIndex);
            IsClickQueryBtn = 0;
        }

        function ValitedHasLotInfo(postArgs) {
            var LotCount = 0;

            var postArgsLot = new Object();

            postArgsLot["OrgID"] = postArgs["OrgID"]
            postArgsLot["EAttribute1"] = postArgs["LotNo"];
            postArgsLot["EAttribute2"] = postArgs["ItemName"];
            //postArgsLot["EAttribute3"] = postArgs["MOName"];
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=16";
            //            var sUrl = "../BLLItem/QueryEntityMItemB.aspx";&OrgID=142&NAttribute2=143&EAttribute2=X5301000001431
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgsLot,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        LotCount = json.rows[0].EAttribute4;
                    }
                }
            });
            //            var info = { "mitemdesc": strItemDesc, "mitemuom": strItemUom };
            return LotCount;
        }

        function VerifyExistItem() {
            var viReslut="";
            var rows = $('#gridDetail').datagrid('getRows');
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (GetItemDesc(row.ItemName==undefined?"":row.ItemName) == "") {
                    viReslut += "物料" + row.ItemName + "不存在,请检查输入的物料编码！<br>";
                }
            }
            return viReslut;
        }

        var isGetLotNo = 0;
        var strCurrentLotNo = "";
        function AddLotNo() {
            endEditing();
            var strProductDate = $("#txtDocBillDate").datebox("getValue");
            if ($('#txtDocBillDate').datebox('getText') == "") {
                $.messager.alert("操作提示", "生产日期不允许为空", "error");
                return false;
            }
            var viResult = "";
            viResult = VerifyExistItem();
            if (viResult != "") {
                $.messager.alert("操作提示", viResult, "error");
                return false;
            }
            //strProductDate = $("#txtDocBillDate").datebox("getValue");
            var rows = $('#gridDetail').datagrid('getRows');
            for (var i = 0; i < rows.length; i++) {
                var bResult = true;
                var iRowIndex = i;
                var strItemName = rows[i]["ItemName"];
                var strLotNo = rows[i]["LotNo"];
                //var strMoName = rows[i]["MOName"];
                var postArgs = new Object();
                if (strLotNo == "" || strLotNo == null) {
                    if (isGetLotNo == 0) {
                        postArgs["OrgID"] = $('#txtCurrentOrgID').val();
                        //postArgs["MOName"] = strMoName;
                        postArgs["ItemName"] = strItemName;
                        postArgs["LotNo"] = strLotNo;
                        if (ValitedHasLotInfo(postArgs) <= 0) {
                            postArgs["ProductDate"] = strProductDate;
                            if (strItemName != null && strItemName != "") {
                                var sUrl = "../BLLLotInfo/CreateLotInfoForWIP.aspx";
                                $.ajax({
                                    type: "post",
                                    url: sUrl,
                                    data: postArgs,
                                    async: false,
                                    dataType: "xml",
                                    success: function (xml) {
                                        var actionResult = $(xml).find("result").text();
                                        if (actionResult == "fail") {
                                            var errMsg = $(xml).find("errormsg").text();
                                            $.messager.alert("操作提示", errMsg, "error");
                                            bResult = false;
                                        }
                                        else {
                                            isGetLotNo = 1;
                                            strCurrentLotNo = $(xml).find("lotno").text();
                                            editIndex = iRowIndex;
                                            endEditing();
                                            //                strLotNo = $(xml).find("lotno").text();
                                            $('#gridDetail').datagrid('beginEdit', iRowIndex);
                                            var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'LotNo' });
                                            edt.target.val(strCurrentLotNo);
                                            $('#gridDetail').datagrid('endEdit', iRowIndex);

                                            editIndex = iRowIndex;
                                            endEditing();
                                            //                strLotNo = $(xml).find("lotno").text();
                                            $('#gridDetail').datagrid('beginEdit', iRowIndex);
                                            var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'DAttribute3' });
                                            edt.target.val(strProductDate);
                                            $('#gridDetail').datagrid('endEdit', iRowIndex);
                                            endEditing();
                                        }
                                    }
                                });
                            }
                            if (bResult == false)
                                return false;
                        }
                    }
                    else {
                        //strProductDate = GetProductDate(strItemName, strCurrentLotNo);
                        postArgs["OrgID"] = $('#txtCurrentOrgID').val();
                        //postArgs["MOName"] = strMoName;
                        postArgs["ItemName"] = strItemName;
                        postArgs["LotNo"] = strCurrentLotNo;
                        postArgs["ProductDate"] = $("#txtDocBillDate").datebox("getValue");
                        if (ValitedHasLotInfo(postArgs) <= 0) {
                            if (strItemName != null && strItemName != "") {
                                var sUrl = "../BLLLotInfo/CreateLotInfoForWIP.aspx";
                                $.ajax({
                                    type: "post",
                                    url: sUrl,
                                    data: postArgs,
                                    async: false,
                                    dataType: "xml",
                                    success: function (xml) {
                                        var actionResult = $(xml).find("result").text();
                                        if (actionResult == "fail") {
                                            var errMsg = $(xml).find("errormsg").text();
                                            $.messager.alert("操作提示", errMsg, "error");
                                            bResult = false;
                                        }
                                        else {
                                            
                                        }
                                    }
                                });
                            }
                            if (bResult == false)
                                return false;
                        }
                        editIndex = iRowIndex;
                        endEditing();
                        //                strLotNo = $(xml).find("lotno").text();
                        $('#gridDetail').datagrid('beginEdit', iRowIndex);
                        var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'LotNo' });
                        edt.target.val(strCurrentLotNo);
                        $('#gridDetail').datagrid('endEdit', iRowIndex);

                        editIndex = iRowIndex;
                        endEditing();
                        //                strLotNo = $(xml).find("lotno").text();
                        $('#gridDetail').datagrid('beginEdit', iRowIndex);
                        var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'DAttribute3' });
                        edt.target.val(strProductDate);
                        $('#gridDetail').datagrid('endEdit', iRowIndex);
                        endEditing();
                    }
                }
            }
        }

        function AddFastenLotNo() {
            endEditing();
            var strProductDate = $("#txtDocBillDate").datebox("getValue");
            if ($('#txtDocBillDate').datebox('getText') == "") {
                $.messager.alert("操作提示", "生产日期不允许为空", "error");
                return false;
            }
            var viResult = "";
            viResult = VerifyExistItem();
            if (viResult != "") {
                $.messager.alert("操作提示", viResult, "error");
                return false;
            }
            var strFastenLotNo = GetFastenLotNo();
            var strProductDate = $("#txtDocBillDate").datebox("getValue");
            var rows = $('#gridDetail').datagrid('getRows');
            for (var i = 0; i < rows.length; i++) {
                var bResult = true;
                var iRowIndex = i;
                var strItemName = rows[i]["ItemName"];
                var postArgs = new Object();
                postArgs["OrgID"] = $('#txtCurrentOrgID').val();
                //postArgs["MOName"] = strMoName;
                postArgs["ItemName"] = strItemName;
                postArgs["LotNo"] = strFastenLotNo;
                //postArgs["ProductDate"] = $("#txtDocBillDate").datebox("getValue");
                if (ValitedHasLotInfo(postArgs) <= 0) {
                    strProductDate = $("#txtDocBillDate").datebox("getValue");
                    postArgs["ProductDate"] = strProductDate;
                    var sUrl = "../BLLLotInfo/CreateLotInfoForWIP.aspx";
                    $.ajax({
                        type: "post",
                        url: sUrl,
                        data: postArgs,
                        async: false,
                        dataType: "xml",
                        success: function (xml) {
                            var actionResult = $(xml).find("result").text();
                            if (actionResult == "fail") {
                                var errMsg = $(xml).find("errormsg").text();
                                $.messager.alert("操作提示", errMsg, "error");
                                bResult = false;
                            }
                            else {
                            }
                        }
                    });
                    if (bResult == false)
                        return false;

                    endEditing();
                    editIndex = iRowIndex;
                    //                strLotNo = $(xml).find("lotno").text();
                    $('#gridDetail').datagrid('beginEdit', iRowIndex);
                    var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'LotNo' });
                    edt.target.val(strFastenLotNo);
                    $('#gridDetail').datagrid('endEdit', iRowIndex);
                    endEditing();

                    editIndex = iRowIndex;
                    //                strLotNo = $(xml).find("lotno").text();
                    $('#gridDetail').datagrid('beginEdit', iRowIndex);
                    var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'DAttribute3' });
                    edt.target.val(strProductDate);
                    $('#gridDetail').datagrid('endEdit', iRowIndex);
                    endEditing();
                }
                else {
                    strProductDate = GetProductDate(strItemName, strFastenLotNo);
                    postArgs["ProductDate"] = strProductDate;
                    endEditing();
                    editIndex = iRowIndex;
                    //                strLotNo = $(xml).find("lotno").text();
                    $('#gridDetail').datagrid('beginEdit', iRowIndex);
                    var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'LotNo' });
                    edt.target.val(strFastenLotNo);
                    $('#gridDetail').datagrid('endEdit', iRowIndex);
                    endEditing();

                    editIndex = iRowIndex;
                    //                strLotNo = $(xml).find("lotno").text();
                    $('#gridDetail').datagrid('beginEdit', iRowIndex);
                    var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'DAttribute3' });
                    edt.target.val(strProductDate);
                    $('#gridDetail').datagrid('endEdit', iRowIndex);
                    endEditing();
                }
            }
        }

        function GetProductDate(itemname,lotno) { 
            var productdate ="";
            var postArgs = new Object();
            postArgs["EAttribute1"] = itemname;
            postArgs["EAttribute2"] = lotno;
            var sUrl = "../BLLTrans/GetLotInfo.aspx?";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "xml",
                async: false,
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        if ($(xml).find("retmsg").text() != "") {
                            productdate = $(xml).find("retmsg").text();
                        }
                    }
                }
            });
            return productdate;
        }

        function GetFastenLotNo() {
            //BLLTrans/GetFastenLotNo.aspx?EAttribute1=FASTEN_LOT_NO
            var fastenlotno ="";
            var postArgs = new Object();
            postArgs["EAttribute1"] = "FASTEN_LOT_NO";
            var sUrl = "../BLLTrans/GetProfileValue.aspx?";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "xml",
                async: false,
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        if ($(xml).find("retMsg").text() != "") {
                            fastenlotno = $(xml).find("retMsg").text();
                        }
                    }
                }
            });
            return fastenlotno;
        }

        function ShowSaleOrderList()
        {
            var strOrder = "";
            var rows = $('#gridDetail').datagrid('getRows');
            for (var i = 0; i < rows.length; i++)
            {
                if (rows[i].SaleOrderNo != undefined && rows[i].SaleOrderNo != "")
                    strOrder = strOrder + rows[i].SaleOrderNo + "/";
            }
            if (strOrder.length > 0)
                strOrder = strOrder.substring(0, strOrder.length - 1);
            $("#txtSaleOrderNoEdit").val(strOrder);
        }

        function QueryBillByBarcode()
        {
            var postArgs = new Object();
            postArgs["VendorID"] = $("#txtVendorID").val();
            postArgs["DeliveryBarcode"] = $("#txtDeliveryBarcodeEdit").val();
            var sUrl = "../BLLReceiveBill/QueryEntityReceiveBill.aspx";
            var vSuccess = "";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                success: function (json)
                {
                    if (json.total > 0)
                    {
                        var jsonRow = json.rows[0];
                        setValueJSON(jsonRow, "tableEdit", undefined);
                        QueryBillByBarcodeDetail();
                    }
                }
            });
        }
        function QueryBillByBarcodeDetail()
        {
            var postArgs = new Object();
            postArgs["DeliveryBarcode"] = $("#txtDeliveryBarcodeEdit").val();
            var sUrl = "../BLLReceiveBillDetail/QueryEntityReceiveBillDetailExtend.aspx";
            var vSuccess = "";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                success: function (json)
                {
                    if (json.total > 0)
                    {
                        $("#txtSegCodeQuery").val(json.rows[0].SegName);
                        ShowSegName();
                    }
                    $('#gridDetail').datagrid('loadData', json); //绑定数据
                }
            });
        }

        var vendorJsonQuery = null;
        function GoToPrintLabel() {
            //            var rows = $('#gridDetail').datagrid('getRows');
            //            if (rows == null || rows.length == 0) {
            //                $.messager.alert("操作提示", "选择打印数据为空！", "error");
            //            }

            var rows = $('#gridDetail').datagrid('getRows');
            if (rows == null || rows.length == 0) {
                $.messager.alert("操作提示", "打印数据为空！", "error");
                return;
            }

            var json;
            json = json + "]}";
            json = '{';
            json = json + '"total":"' + rows.length + '",';
            json = json + '"rows":[';
            for (var i = 0; i < rows.length; i++) {
                var strLot = rows[i].LotNo;
                var strItemName = rows[i].ItemName;
                var strQty = rows[i].Qty;
                var strProductDate = rows[i].DAttribute3;
                var strItemDesc = rows[i].EAttribute3;
                json = json + "{";
                json = json + '"LotNo":"' + strLot + '",';
                json = json + '"ItemName":"' + strItemName + '",';
                json = json + '"ItemDesc":"' + strItemDesc + '",';
                json = json + '"Qty":"' + strQty + '",';
                json = json + '"ProductDate":"' + strProductDate + '",';
                json = json + '}';
                if (i < rows.length - 1) {
                    json = json + ',';
                }
            }
            json = json + ']}';
            //if (vendorJsonQuery != null) {
            //openWindow(encodeURI("../KLabelBasic/FMOItemLotLabelPrint.aspx?ConditionList=" + json), "物料批次标签打印");
            SetGlobalValue(json);
            openWindow(encodeURI("../KLabelBasic/FMOItemLotLabelPrint.aspx?"), "物料批次标签打印");
           // }
        }
    </script>
    <script type="text/javascript">
        $(function ()
        {
            var opts = $('#gridDetail').datagrid('options');
            //设置默认数据条数
            opts.pageSize = 200;
            $('#gridDetail').datagrid({
                fit: true,
                rownumbers: true,
                singleSelect: true,
                selectOnCheck: false,
                checkOnSelect: false,
                remoteSort: false,
                multiSort: true,
                striped: true,
                frozenColumns: [[{ field: 'ck', checkbox: true}]],
                columns: [[
            { field: 'PLF_PrimaryKeyValue', title: 'ID', width: 80, align: 'center', sortable: 'true', hidden: 'true' },
            { field: 'Seq', title: 'Seq', width: 80, align: 'center', sortable: 'true', hidden: 'true' },
            { field: 'CustomerCode', title: '欣旺达料号', width: 100, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
//            { field: 'BillLineID', title: 'ID', width: 100, align: 'center', sortable: 'true' },
            { field: 'ItemName', title: '*物料编号', width: 120, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'EAttribute3', title: '物料名称', width: 180, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,500]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'EAttribute4', title: '库位', width: 100, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'LotNo', title: '批号', width: 120, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'Qty', title: '*数量', width: 80, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
//            { field: 'PONo', title: '采购订单号', width: 100, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
//            { field: 'EAttribute13', title: '供应商名称', width: 80, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'DAttribute3', title: '生产日期', width: 100, align: 'center', sortable: 'true', editor: 'text' },
//            { field: 'MOName', title: '工单号', width: 120, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } },
            { field: 'FromLineName', title: '拉别', width: 80, align: 'center', sortable: 'true', editor: 'text', editor: { type: 'validatebox', options: { validType: 'length[0,20]'} }, styler: function (value, row, index) { return 'background-color:#B8D5F1;' } }

            ]],
                toolbar: '#gridDetailToolBar',
                onClickCell: onClickCellDetail
            });
        });

        function CancelUpload() {
		  var strBillNo = $("#txtDocBillCode").val();
            if ($("#txtDocBillCode").val() == "") {
                $.messager.alert("单据号为空！");
            }
			if (VerificateIsCloseOrCancel(strBillNo) > 0) {
                                $.messager.alert("操作提示", "已关闭、已取消单据不允许做单据取消！", "error");
                                return;
                            }
            else {
                var postArgs = new Object();
                var strBillNo = $("#txtDocBillCode").val();
                var CurrentOrgID = $("#txtCurrentOrgID").val();
                if (VerificateHasTrans(strBillNo) > 0) {
                    $.messager.alert("操作提示", "已做事务处理不允许做单据取消！", "error");
                    return;
                }
                else {
                    var sUrl = "../BLLTrans/SubmitEntityInvMakeCancel.aspx?OrgID=" + CurrentOrgID + "&BillNo=" + strBillNo;
                    $.post(sUrl, postArgs, function (xml, status) {
                        var actionResult = $(xml).find("result").text();
                        if (actionResult == "success") {
                            $.messager.show({ title: '操作提示', msg: '提交成功', timeout: 5000, showType: 'slide' });

                            $("#A1").linkbutton("disable");
                            $("#A2").linkbutton("disable");
                            $("#A3").linkbutton("disable");
                            $("#btnCancel").linkbutton("disable");
                            $("#btnAdd").linkbutton("disable");
							
							$("#cbxOutInv").combobox("setValue", '');
        $("#cbxInvTransReason").combobox("setValue", '');
        $("#txtCreateFromIssueBill").val('');
		$("#txtDocBillCode1").val(''); 
		$("#txtMemo").val('');
        $("#txtPersonApply").val('');
		$("#txtApplyDate").combo("setText", '');
		$("#cbxCustomerName").val('');
		$("#txtDocBillDate").combo("setText", '');
		$("#txtMakeBillUser").val('');
                        }
                        else {
                            var errMsg = $(xml).find("errormsg").text();
                            $.messager.alert("操作提示", errMsg, "error");
                        }
                    });
                }
            }
        }

        function VerificateHasTrans(strBillNo) {

            var postArgs = new Object();
            var hasTrans = 0; //是否已经做了事务处理
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=21&OrgID=" + $("#txtCurrentOrgID").val() + "&BillNo=" + strBillNo;
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        hasTrans = json.rows[0].NAttribute2;
                    }
                }
            });
            return hasTrans;
        }

        function VerificateIsCloseOrCancel(strBillNo) {

            var postArgs = new Object();
            var isCloseOrCancel = 0; //是否已关闭或取消
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=22&OrgID=" + $("#txtCurrentOrgID").val() + "&BillNo=" + strBillNo;
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        isCloseOrCancel = json.rows[0].NAttribute2;
                    }
                }
            });
            return isCloseOrCancel;
        }

        function CloseTrans() {
            if ($("#txtDocBillCode").val() == "") {
                $.messager.alert("操作提示", "单据号为空！", "error");
            }
            else {
                $(function () {
                    $.messager.defaults = { ok: "是", cancel: "否" };
                    $.messager.confirm("操作提示", "您确定要执行单据关闭？", function (data) {
                        if (data) {
                            var postArgs = new Object();
                            var strBillNo = $("#txtDocBillCode").val();
                            var CurrentOrgID = $("#txtCurrentOrgID").val();
                            if (VerificateIsCloseOrCancel(strBillNo) > 0) {
                                $.messager.alert("操作提示", "已关闭、已取消单据不允许做单据关闭！", "error");
                                return;
                            }
                            var sUrl = "../BLLTrans/SubmitEntityInvMakeClose.aspx?OrgID=" + CurrentOrgID + "&BillNo=" + strBillNo;
                            $.post(sUrl, postArgs, function (xml, status) {
                                var actionResult = $(xml).find("result").text();
                                if (actionResult == "success") {
                                    $.messager.show({ title: '操作提示', msg: '提交成功', timeout: 5000, showType: 'slide' });

                                    $("#A1").linkbutton("disable");
                                    $("#A2").linkbutton("disable");
                                    $("#A3").linkbutton("disable");
                                    $("#btnCancel").linkbutton("disable");
                                    $("#btnAdd").linkbutton("disable");

                                    //                        var sUrl = "../BLLDocBill/UpdateEntityDocBill.aspx";
                                    //                        postArgs["BillNo"] = strBillNo;
                                    //                        postArgs["Status"] = "lm_uploaded";
                                    //                         $.post(sUrl, postArgs, function (xml, status) {
                                    //                         if (status == "success")
                                    //                         {
                                    //                         $.messager.alert("Ok");
                                    //                         }
                                    //                         });
                                }
                                else {
                                    var errMsg = $(xml).find("errormsg").text();
                                    $.messager.alert("操作提示", errMsg, "error");
                                }
                            });
                        }
                    });
                });

            }
        }

        function RemoveDetail() {
            $.messager.confirm('确认', '确认要删除吗?', function (r) {
                if (r) {
                    if ($("#txtDocBillCode").val() != "") {
                        if (VerificateHasTrans($("#txtDocBillCode").val()) > 0) {
                            $("#A1").linkbutton("disable");
                            $("#A2").linkbutton("disable");
                            $("#A3").linkbutton("disable");
                            //$("#A4").linkbutton("disable");
                            $("#btnCancel").linkbutton("disable");
                            $("#btnAdd").linkbutton("disable");
                            $.messager.alert("操作提示", "做过事务不能更新！", "error");
                            return;
                        }
                    }
                    var rows = $('#gridDetail').datagrid('getChecked');
                    var rowsAll = $('#gridDetail').datagrid('getRows');
                    if (rows.length == rowsAll.length) {
                        $.messager.alert('操作提示', '不允许删除所有明细，请取消单据!', 'info');
                        return;
                    }
                    if (!rows || rows.length == 0) {
                        $.messager.alert('操作提示', '请选择要删除的数据!', 'info');
                        return;
                    }
                    var copyRows = [];
                    for (var j = 0; j < rows.length; j++) {
                        copyRows.push(rows[j]);
                    }
                    for (var i = 0; i < copyRows.length; i++) {
                        var index = $('#gridDetail').datagrid('getRowIndex', copyRows[i]);
                        $('#gridDetail').datagrid('deleteRow', index);
                    }
                    if ($("#txtDocBillCode").val() != "") {
                        var sUrl = "../BLLDocBillDetail/DeleteEntityDocBillDetail.aspx";
                        var deltimes = 0;
                        $.each(rows, function (index, item) {
                            var postArgs = new Object();
                            postArgs["un"] = Date.parse(new Date());
                            postArgs["InstID"] = item.PLF_PrimaryKeyValue;

                            postArgs["OrgID"] = "<%=OrgID %>";

                            //postArgs["__LOGON_USERCODE"] = "<%=GetUserCode() %>";
                            if (typeof (BeforeDeleteData) == "function") {
                                var beforeDeleteDataParam = { postArgs: postArgs };
                                BeforeDeleteData(beforeDeleteDataParam);
                                if (beforeDeleteDataParam.cancel != undefined && beforeDeleteDataParam.cancel == true) {
                                    $.messager.progress('close');
                                    return;
                                }
                            }
                            $.ajax({
                                type: "post",
                                url: sUrl,
                                data: postArgs,
                                success: function (data) {
                                    var actionResult = $(data).find("result").text();
                                    if (actionResult == "success") {
                                        deltimes++;
                                        if (deltimes == rows.length) {
                                            $.messager.show({ title: '操作提示', msg: '共删除 ' + deltimes + ' 条 数据', timeout: 5000, showType: 'slide' });
                                            if ($("#txtDocBillCode").val() != "") {
                                                queryDataNew(1, 0);
                                            }
                                        }
                                    }
                                    else {
                                        var errMsg = $(data).find("errormsg").text();
                                        $.messager.alert("操作提示", errMsg, "error");
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.messager.progress('close');
                                    $("#winSubQuery").window({
                                        title: textStatus + ':' + XMLHttpRequest.statusText,
                                        closed: true,
                                        iconCls: 'icon-cancel',
                                        content: XMLHttpRequest.responseText
                                    });
                                    $("#winSubQuery").window("open");
                                }
                            });
                        });
                    }
                }
            });
        }

        function GetMaxSeq(rows) {
            var maxSeq = 0;
            if (rows.length > 0) {
                maxSeq = rows[0].Seq == undefined ? 0 : rows[0].Seq;
                for (var i = 0; i < rows.length; i++) {
                    if (parseFloat(maxSeq) <parseFloat(rows[i].Seq)) {
                        maxSeq = rows[i].Seq;
                    }
                }
            }
            return maxSeq;
        }

        function ValidateInputInfo() {
            var result = "ok";
            //表头数据验证
            if ($('#cbxOutInv').combobox('getText') == "" || $('#cbxBusinessUnit').combobox('getText') == "" || $('#cbxInvDepartment').combobox('getText') == ""
            || $('#txtDocBillDate').datebox('getText') == "" || $('#txtMakeBillUser').val() == "" || $('#txtApplyDate').datebox('getText') == ""
            || $('#cbxGenericDispositions').combobox('getText') == "") {
                result = "head_lack";
            }
            else {
                //明细数据验证
                $("#gridDetail").datagrid("acceptChanges");
                var rows = $('#gridDetail').datagrid('getRows');
                if (rows == null || rows.length == 0) {
                    result = "line_null";
                }
                if (rows.length > 0) {
                    for (var i = 0; i < rows.length; i++) {
                        if (rows[i].ItemName == undefined || rows[i].ItemName == "" || rows[i].Qty == undefined || rows[i].Qty == "")
                            result = "line_lack";
                    }
                }
            }
            return result;
        }

        function VerifyLotInfo(itemname, lotno) {
            var lotcount = 0;
            var postArgs = new Object();
            var sUrl = "../BLLTrans/VerifyLotInfo.aspx?OrgID=" + $("#txtCurrentOrgID").val() + "&EAttribute2=" + lotno + "&EAttribute1=" + itemname;

            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "xml",
                async: false,
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        if ($(xml).find("lotcount").text() != "") {
                            lotcount = $(xml).find("lotcount").text();
                        }
                    }
                }
            });
            return lotcount;
        }

        function VerifyMoAndItemInfo(moname, itemname) {
            var result = 0;
            var postArgs = new Object();
            var sUrl = "../BLLTrans/VerifyMoAndItemInfo.aspx?OrgID=" + $("#txtCurrentOrgID").val() + "&MOName=" + moname + "&ItemName=" + itemname;

            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "xml",
                async: false,
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        if ($(xml).find("retmsg").text() != "") {
                            result = $(xml).find("retmsg").text();
                        }
                    }
                }
            });
            return result;
        }

        function ValidateSaveData() {
            var result = "";
            if (CheckBillNoData($("#txtCreateFromIssueBill").val()).result == "Fail") {
                result += "领料单号" + $("#txtCreateFromIssueBill").val() + "已经生成入库单,请检查！<br>";
            }
            var rows = $('#gridDetail').datagrid('getRows');
            var SumQty = 0;
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (VerifyLotInfo(row.ItemName, row.LotNo) <= 0) {
                    result += "物料" + row.ItemName + "的批次" + row.LotNo + "不存在,请重新生成批次或输入有效的批次！<br>";
                }

               //2020-12-17 xdm edit  修改不使用parseFloat相加，因为会有精度丢失问题
               //SumQty = parseFloat(SumQty) + parseFloat(row.Qty);
	SumQty = calAdd(SumQty,row.Qty);
               //edit end


               // if (row.MOName != "") {
                 //  if (VerifyMoAndItemInfo(row.MOName, null) <= 0) {
                //        result += "工单号" + row.MOName + "不存在,请重新输入有效的工单号！<br>";
                 //   }
                 //   else if (VerifyMoAndItemInfo(row.MOName, row.ItemName) <= 0) {
                 //       result += "物料" + row.ItemName + "对应的工单" + row.MOName + "错误,请重新输入对应的工单号！<br>";
                  //  }
                //}
//                if (GetItemBatchMode(row.ItemName) == "X" && row.LotNo == "") {
//                    result += "物料" + row.ItemName + "缺批次,请输批次！<br>";
//                }
//                if (GetLocId(row.EAttribute4) == null || GetLocId(row.EAttribute4) == "") {
//                    result += "物料" + row.ItemName + "库位不存在,请检查库位信息！<br>";
//                }
            }
            var CheckResultByHZM = CheckHZMData();

            //2020-12-17 edit by xdm
            //var CheckResultByIssue = parseFloat(rows.length.toString()) + parseFloat(SumQty.toString());
            //if (CheckResultByHZM - parseFloat(CheckResultByIssue) != 0) {
                //result += "领料单加载的数据与当前界面数据不一致,请检查是否存在不合理操作！<br>";
            //}
            var CheckResultByIssue = calAdd(rows.length.toString(),SumQty.toString());
            if (Number(CheckResultByHZM) != Number(CheckResultByIssue)) {
	result += "领料单加载的数据与当前界面数据不一致,请检查是否存在不合理操作！<br>";
            }
           //edit end

            return result;
        }

                                //2020-12-17 xdm 添加该函数
		//加法函数，用来得到精确的加法结果
		//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
		//返回值：arg1加上arg2的精确结果
		function calAdd(arg1, arg2) {
			var r1, r2, m;
			try {
				r1 = arg1.toString().split(".")[1].length;
			} catch (e) {
				r1 = 0;
			}
			try {
				r2 = arg2.toString().split(".")[1].length;
			} catch (e) {
				r2 = 0;
			}
			m = Math.pow(10, Math.max(r1, r2));
			var result = (arg1 * m + arg2 * m) / m;
			return result;
		}
		//add end

        function CheckHZMData() {
            var strResult = "0";
            var postArgs = new Object();
            postArgs["EAttribute1"] = $("#txtCreateFromIssueBillnew").val();
            var sUrl = "../BLLTrans/VerifyHZMByIssueBillMP.aspx?";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                async: false,
                dataType: "xml",
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        strResult = $(xml).find("retmsg").text()
                    }
                }
            });
            return parseFloat(strResult);
        }

        function GetItemBatchMode(itemName) {
            var strBatchMode = "";
            var postArgs = new Object();
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=29&OrgID=" + $('#txtCurrentOrgID').val() + "&EAttribute2=" + itemName;
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        strBatchMode = json.rows[0].EAttribute11;
                    }
                }
            });
            return strBatchMode;
        }

        function SaveInvMakeBill() {
            var strStatus = "Initial"; // "lm_initial";更新状态标志20160914

            var valResult = ValidateInputInfo();
            //验证必填项
            if (valResult == "head_lack") {
                $.messager.alert("操作提示", "请输入必填（带*号）项！", "error");
                return;
            }
            if (valResult == "line_null") {
                $.messager.alert("操作提示", "请添加清单行数据！", "error");
                return;
            }
            if (valResult == "line_lack") {
                $.messager.alert("操作提示", "请输入清单行必填（带*号）项！", "error");
                return;
            }
            var verifyResult = "";
            verifyResult = ValidateSaveData();
            if (verifyResult != "") {
                $.messager.alert("操作提示", verifyResult, "error");
                return;
            }
			
			var Projectneed = $('#cbxGenericDispositions').combobox('getText');
			if ($('#cbxOutInv').combobox('getText').indexOf("受托") < 0 && Projectneed == "受托方入库") 
            {
			    $.messager.alert("操作提示", "事务类型为受托方入库只能入受托仓库，请确认选择的仓库是否为受托仓！！！", "error");
			    return;
			}
            if (GetInvType($('#cbxOutInv').combobox('getValue')) == "1" && Projectneed=="受托方入库") 
            {
                $.messager.alert("操作提示", "事务类型为受托方入库只能入费用仓，请确认选择的仓库是否为资产仓！！！", "error");
                return;
            }
            //TO_DO:重新生成杂项入库单逻辑
            if ($("#txtDocBillCode").val() != "") {
			
                if (VerificateHasTrans($("#txtDocBillCode").val()) > 0) {
                    $("#A1").linkbutton("disable");
                    $("#A2").linkbutton("disable");
                    $("#A3").linkbutton("disable");
                    //$("#A4").linkbutton("disable");
                    $("#btnCancel").linkbutton("disable");
                    $("#btnAdd").linkbutton("disable");
                    $.messager.alert("操作提示", "做过事务不能更新！", "error");
                    return;
                }
				if (VerificateIsCloseOrCancel($("#txtDocBillCode").val()) > 0) {
                                $.messager.alert("操作提示", "已关闭、已取消单据不允许更新！", "error");
                                return;
                            }
							
				if($("#txtCreateFromIssueBillnew").val()!=$("#txtCreateFromIssueBill").val())
				{
				$.messager.alert("操作提示", "保存的出货单与输入的不一致，请确认！", "error");
                    return;
				}
                if (confirm("调拨单已存在，是否覆盖原单据？")) {
                    //更新杂项入库单
                    var postArgs = new Object();
                    var locId = 0;
                    postArgs = getValue(postArgs, "tableEdit");
                    if ($('#chkIsIQCSummit').is(':checked')) {
                        postArgs["NAttribute5"] = "1";
                    }
                    else {
                        postArgs["NAttribute5"] = "0";
                    }
                    postArgs["RcvInvCode"] = $("#cbxOutInv").combobox("getValue");
                    postArgs["Status"] = strStatus; // "lm_initial";更新状态标志20160914
                    postArgs["Memo"] = $("#txtMemo").val();
                    postArgs["BillCategory"] = "INV_ZRK";
					postArgs["BillType"]="INV_WYZRK";
                    //            postArgs["RcvInvCode"] = $("#cbxInInv").combobox("getValue");
                    postArgs["EAttribute7"] = $("#cbxBusinessUnit").combobox("getValue");
                    postArgs["EAttribute8"] = $("#cbxInvDepartment").combobox("getValue");
                    postArgs["EAttribute9"] = $("#cbxInvTransReason").combobox("getValue");
                    postArgs["EAttribute10"] = $("#cbxGenericDispositions").combobox("getText");
					postArgs["EAttribute15"]=$("#txtCreateFromIssueBillnew").val();
                    postArgs["DAttribute1"] = $("#txtApplyDate").combobox("getValue");
                    postArgs["EAttribute6"] = $("#txtPersonApply").val();
                    postArgs["InstID"] = $("#txtInstID").val();
                    postArgs["CustomerCode"] = $("#cbxCustomerName").combobox('getValue');
                    postArgs["EAttribute13"] = $("#cbxCustomerName").combobox('getText');
                    postArgs["OrgID"] = $("#txtCurrentOrgID").val(); 
                    var sUrl = "../BLLTrans/UpdateEntityInvMake.aspx";
                    $.ajax({
                        type: "post",
                        url: sUrl,
                        data: postArgs,
                        async: false,
                        dataType: "json",
                        success: function (json) {
                            if (json.result == 'fail') {
                                $.messager.alert("操作提示", json.errormsg, "error");
                                //                                            strFlag = "N";
                            }
                        }
                    });
                    //                                if (strFlag == "N")
                    //                                    return;
                    //更新杂项入库单明细行状态
                    $("#gridDetail").datagrid("acceptChanges");
                    var rows = $("#gridDetail").datagrid("getRows");
                    var maxSeqValue = GetMaxSeq(rows);
                    var curMaxSeqValue = parseInt(maxSeqValue);
                    var iBillDetailCount = rows.length;
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var postArgs = new Object();
                        postArgs["RcvInvCode"] = $("#cbxOutInv").combobox("getValue");
                        postArgs["Status"] = strStatus; // "lm_initial";更新状态标志20160914
                        postArgs["Memo"] = $("#txtMemo").val();
                        postArgs["BillCategory"] = "INV_ZRK";
						postArgs["BillType"]="INV_WYZRK";
                        postArgs["Seq"] = row.Seq;
                        postArgs["BillNo"] = $("#txtDocBillCode").val();
                        //                postArgs["RcvInvCode"] = $("#cbxInInv").combobox("getValue");
                        postArgs["ItemName"] = row.ItemName;
                        postArgs["EAttribute7"] = $("#cbxBusinessUnit").combobox("getValue");
                        postArgs["EAttribute8"] = $("#cbxInvDepartment").combobox("getValue");
                        postArgs["EAttribute9"] = $("#cbxInvTransReason").combobox("getValue");
                        postArgs["EAttribute10"] = $("#cbxGenericDispositions").combobox("getText");
                        postArgs["DAttribute1"] = $("#txtApplyDate").combobox("getValue");
                        postArgs["EAttribute6"] = $("#txtPersonApply").val();
                        postArgs["EAttribute4"] = row.EAttribute4;
                        postArgs["LotNo"] = row.LotNo;
                        postArgs["Qty"] = row.Qty;
                        locId = GetLocId(row.EAttribute4);
                        postArgs["EAttribute11"] = locId;
                        postArgs["PONo"] = row.PONo;
                        postArgs["MOName"] = row.MOName;
                        postArgs["FromLineName"] = row.FromLineName;
                        postArgs["CustomerCode"] = row.CustomerCode; //客供料号
                        postArgs["EAttribute13"] = row.EAttribute13; //库位
                        postArgs["DAttribute2"] = row.DAttribute3; //记录标签生产日期
                        postArgs["OrgID"] = $("#txtCurrentOrgID").val(); 
                        if (row.PLF_PrimaryKeyValue != undefined) {
                            postArgs["InstID"] = row.PLF_PrimaryKeyValue;

                            var sUrl = "../BLLTrans/UpdateEntityInvMakeDetail.aspx";
                            $.post(sUrl, postArgs, function (xml, status) {
                                if (status == "success") {
                                    var actionResult = $(xml).find("result").text();
                                    if (actionResult == "success") {
                                        iBillDetailCount--;
                                        if (iBillDetailCount == 0) {
                                            $.messager.progress('close');
                                            $.messager.show({ title: '操作提示', msg: '更新成功!', timeout: 5000, showType: 'slide' });
                                        }

                                    }
                                    else {
                                        $.messager.progress('close');
                                        var errMsg = $(xml).find("errormsg").text();
                                        $.messager.alert("操作提示", errMsg, "error");
                                    }
                                }
                            });
                        }
                        else {
                            postArgs["Seq"] = ++curMaxSeqValue;
                            var sUrl = "../BLLTrans/InsertEntityInvMakeDetail.aspx";
                            $.post(sUrl, postArgs, function (xml, status) {
                                if (status == "success") {
                                    var actionResult = $(xml).find("result").text();
                                    if (actionResult == "success") {
                                        iBillDetailCount--;
                                        if (iBillDetailCount == 0) {
										 $("#txtDocBillCode").val(strBillNo);
				                         $("#txtDocBillCode1").val(strBillNo);
                                            queryDataNew(1, 0);
                                            $.messager.progress('close');
                                            $.messager.show({ title: '操作提示', msg: '更新成功!', timeout: 5000, showType: 'slide' });
                                        }

                                    }
                                    else {
                                        $.messager.progress('close');
                                        var errMsg = $(xml).find("errormsg").text();
                                        $.messager.alert("操作提示", errMsg, "error");
                                    }
                                }
                            });
                        }

                    }
                }
                else {
                    return;
                }
            }
            else {
                $("#gridDetail").datagrid("acceptChanges");
                var rows = $("#gridDetail").datagrid("getRows");
                if (rows.length <= 0) {
                    $.messager.alert("操作提示", "请添加行信息!", "error");
                    return;
                }
                var strBillNo = "";
                var CurrentOrgID = "";
                CurrentOrgID = $("#txtCurrentOrgID").val();
                var postArgs = new Object();
                postArgs = getValue(postArgs, "tableEdit");
                if ($('#chkIsIQCSummit').is(':checked')) {
                    postArgs["NAttribute5"] = "1";
                }
                else {
                    postArgs["NAttribute5"] = "0";
                }
                postArgs["RcvInvCode"] = $("#cbxOutInv").combobox("getValue");
                postArgs["Status"] = strStatus; // "lm_initial";更新状态标志20160914
                postArgs["Memo"] = $("#txtMemo").val();
                postArgs["BillCategory"] = "INV_ZRK";
				postArgs["BillType"]="INV_WYZRK";
                //            postArgs["RcvInvCode"] = $("#cbxInInv").combobox("getValue");
                postArgs["EAttribute7"] = $("#cbxBusinessUnit").combobox("getValue");
                postArgs["EAttribute8"] = $("#cbxInvDepartment").combobox("getValue");
                postArgs["EAttribute9"] = $("#cbxInvTransReason").combobox("getValue");
                postArgs["EAttribute10"] = $("#cbxGenericDispositions").combobox("getText");
                postArgs["DAttribute1"] = $("#txtApplyDate").combobox("getValue");
                postArgs["EAttribute6"] = $("#txtPersonApply").val();
                postArgs["CustomerCode"] = $("#cbxCustomerName").combobox('getValue');
                postArgs["EAttribute13"] = $("#cbxCustomerName").combobox('getText');
				postArgs["EAttribute15"] = $("#txtCreateFromIssueBillnew").val();
                postArgs["OrgID"] = $("#txtCurrentOrgID").val(); 
                var sUrl = "../BLLTrans/InsertEntityInvMake.aspx";
                $.ajax({
                    type: "post",
                    url: sUrl,
                    data: postArgs,
                    async: false,
                    dataType: "json",
                    success: function (json) {
                        if (json.result == 'fail') {
                            $.messager.alert("操作提示", json.errormsg, "error");
                        }
                        else {
                            strBillNo = json.rows[0].BillNo;
                            //$("#txtDeliveryID").val(json.rows[0].DeliveryHeadID);
                        }
                    }
                });
                if (strBillNo == undefined || strBillNo == "") {
                    $.messager.progress('close');
                    return;
                }
                $("#txtDocBillCode").val(strBillNo);
				$("#txtDocBillCode1").val(strBillNo);

                //            $("#gridDetail").datagrid("acceptChanges");
                //            var rows = $("#gridDetail").datagrid("getRows");
                var iBillDetailCount = rows.length;
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    var postArgs = new Object();
                    postArgs["RcvInvCode"] = $("#cbxOutInv").combobox("getValue");
                    postArgs["Status"] = strStatus; // "lm_initial";更新状态标志20160914
                    postArgs["Memo"] = $("#txtMemo").val();
                    postArgs["BillCategory"] = "INV_ZRK";
					postArgs["BillType"]="INV_WYZRK";
                    postArgs["Seq"] = i + 1;
                    postArgs["BillNo"] = strBillNo;
                    //                postArgs["RcvInvCode"] = $("#cbxInInv").combobox("getValue");
                    postArgs["ItemName"] = row.ItemName;
                    postArgs["EAttribute7"] = $("#cbxBusinessUnit").combobox("getValue");
                    postArgs["EAttribute8"] = $("#cbxInvDepartment").combobox("getValue");
                    postArgs["EAttribute9"] = $("#cbxInvTransReason").combobox("getValue");
                    postArgs["EAttribute10"] = $("#cbxGenericDispositions").combobox("getText");
                    postArgs["DAttribute1"] = $("#txtApplyDate").combobox("getValue");
                    postArgs["EAttribute6"] = $("#txtPersonApply").val();
                    postArgs["EAttribute4"] = row.EAttribute4;
                    postArgs["LotNo"] = row.LotNo;
                    postArgs["Qty"] = row.Qty;
                    locId = GetLocId(row.EAttribute4);
                    postArgs["EAttribute11"] = locId;
                    postArgs["PONo"] = row.PONo;
                    postArgs["EAttribute13"] = row.EAttribute13;
                    postArgs["MOName"] = row.MOName;
                    postArgs["FromLineName"] = row.FromLineName;
                    postArgs["CustomerCode"] = row.CustomerCode; //客供料号
                    postArgs["DAttribute2"] = row.DAttribute3; //记录标签生产日期
                    postArgs["OrgID"] = $("#txtCurrentOrgID").val(); 

                    var sUrl = "../BLLTrans/InsertEntityInvMakeDetail.aspx";
                    $.post(sUrl, postArgs, function (xml, status) {
                        if (status == "success") {
                            var actionResult = $(xml).find("result").text();
                            if (actionResult == "success") {
                                iBillDetailCount--;
                                if (iBillDetailCount == 0) {
                                    queryDataNew(1, 0);
                                    $.messager.progress('close');
                                    $.messager.show({ title: '操作提示', msg: '保存成功!', timeout: 5000, showType: 'slide' });
                                }


                            }
                            else {
                                $.messager.progress('close');
                                var errMsg = $(xml).find("errormsg").text();
                                $.messager.alert("操作提示", errMsg, "error");
                            }
                        }
                    });
                }
            }
//            if ($('#chkIsIQCSummit').is(':checked')) {
//                if (confirm("是否报检杂项入库单？")) {
//                    SummitToIQC();
//                }
//            }
        }

        function GetLocId(loccode) {
            var locid = 0;
            if (loccode != "") {
                var postArgs = new Object();
                postArgs["EAttribute2"] = loccode;
                var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=20&OrgID=" + $("#txtCurrentOrgID").val();
                $.ajax({
                    type: "post",
                    url: sUrl,
                    data: postArgs,
                    dataType: "json",
                    async: false,
                    success: function (json) {
                        if (json.total > 0) {
                            locid = json.rows[0].NAttribute1;
                        }
//                        else {
//                            $.messager.progress('close');
//                            $.messager.alert("操作提示", "货位不存在，请检查货位!", "error");
//                            return;
//                        }
                    }
                });
            }
            return locid;
        }

        function SummitToIQC() {
            if ($("#txtDocBillCode").val() == "") {
                $.messager.alert("操作提示", "请先生成单据号！", "error");
            }
            else {
                if (confirm("是否报检杂项入库单？")) {
                    var postArgs = new Object();
                    var strBillNo = $("#txtDocBillCode").val();
                    var CurrentOrgID = $("#txtCurrentOrgID").val()
                    var sUrl = "../BLLTrans/SubmitToIQC.aspx?OrgID=" + CurrentOrgID + "&BillNo=" + strBillNo;
                    $.post(sUrl, postArgs, function (xml, status) {
                        var actionResult = $(xml).find("result").text();
                        if (actionResult == "success") {
                            $.messager.show({ title: '操作提示', msg: '报检成功', timeout: 5000, showType: 'slide' });

                            $("#A1").linkbutton("disable");
                            $("#A2").linkbutton("disable");
                            $("#A3").linkbutton("disable");
                            $("#btnCancel").linkbutton("disable");
                            $("#btnAdd").linkbutton("disable");
                            $("#btnAddLotNo").linkbutton("disable");
                            $("#btnIQCSummit").linkbutton("disable");
                        }
                        else {
                            var errMsg = $(xml).find("errormsg").text();
                            $.messager.alert("操作提示", errMsg, "error");
                        }
                    });
                }
            }
        }

        function UploadToEBS() {
            if ($("#txtDocBillCode").val() == "") {
                $.messager.alert("操作提示", "请先生成单据号！", "error");
            }
            else {
                $("#A2").linkbutton("disable");
                var postArgs = new Object();
                var strBillNo = $("#txtDocBillCode").val();
                var CurrentOrgID = $("#txtCurrentOrgID").val()
                var sUrl = "../BLLTrans/SubmitEntityMiscIn.aspx?OrgID=" + CurrentOrgID + "&BillNo=" + strBillNo;
                $.post(sUrl, postArgs, function (xml, status) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        $.messager.show({ title: '操作提示', msg: '提交成功', timeout: 5000, showType: 'slide' });

                        $("#A1").linkbutton("disable");
                        $("#A2").linkbutton("disable");
                        $("#A3").linkbutton("disable");
                        $("#btnCancel").linkbutton("disable");
                        $("#btnAdd").linkbutton("disable");

                        //                        var sUrl = "../BLLDocBill/UpdateEntityDocBill.aspx";
                        //                        postArgs["BillNo"] = strBillNo;
                        //                        postArgs["Status"] = "lm_uploaded";
                        //                         $.post(sUrl, postArgs, function (xml, status) {
                        //                         if (status == "success")
                        //                         {
                        //                         $.messager.alert("Ok");
                        //                         }
                        //                         });
                    }
                    else {
                        //$("#A2").linkbutton("enable");
                        var errMsg = $(xml).find("errormsg").text();
                        $.messager.alert("操作提示", errMsg, "error");





                    }
                });
            }
        }
    </script>
    <script type="text/javascript">
        var __btnPrintText;
        function PrintButtonClick_btnPrint_Core()
        {
		 if($('#txtDocBillCode').val()=="")
			{
			 $.messager.alert("操作提示", "单据号为空，请输入单据号", "error");
			 return;
			 
			}
            var strMergeRows = "N";
            var strPrintMode = "Preview";
            var __printArgs = {
                loginUserCode: "<%=GetUserCode() %>",
                loginUserName: "<%=GetUserName() %>",
                loingOrganizationID: "<%=OrgID %>",
                relativePath: __PageRootRelativePath,
                inputControlIdList: "",
                inputGridColumnName: "",
                checkBillPrintedQty: "N",
                labelTitleControlId: "txtDocBillCode",
                mergeRows: strMergeRows,
                //printMode: strPrintMode,
                moduleCode: "MiscInInvBill"
            };
            var vFlag = LabelPrintStart(__printArgs);
            if (vFlag == false)
            {
                document.getElementById("btnPrint").childNodes[0].childNodes[0].innerText = __btnPrintText;
                $("#btnPrint").removeAttr("disabled");
            }
        }

        function PrintButtonClick_btnPrint()
        {
		 if($('#txtDocBillCode').val()=="")
			{
			 $.messager.alert("操作提示", "单据号为空，请输入单据号", "error");
			 return;
			 
			}
            if ($("#btnPrint").attr("disabled") == "disabled")
                return;
            if (PrePrintCheck() == false)
                return;
            __btnPrintText = $("#btnPrint").text();
            document.getElementById("btnPrint").childNodes[0].childNodes[0].innerText = "正在打印";
            $("#btnPrint").attr("disabled", "disabled");
            setTimeout("PrintButtonClick_btnPrint_Core()", 100);
        }
        function LocalPrintOver()
        {
            document.getElementById("btnPrint").childNodes[0].childNodes[0].innerText = __btnPrintText;
            $("#btnPrint").removeAttr("disabled");
        }
    </script>
    <script type="text/javascript">
        function PrePrintCheck()
        {
            return true;
        }

        // 从SAP取批号
        function GetLabelLotNoSAP()
        {
            var bResult = true;
            var rows = $("#gridDetail").datagrid("getRows");
            for (var i = 0; i < rows.length; i++)
            {
                var iRowIndex = i;
                var strItemName = rows[i]["MItemName"];
                var strVendorCode = rows[i]["EAttribute13"];
                var strLotNo = rows[i]["VendorLotNo"];
                var strProductDate2 = rows[i]["PrintDate"];
                if (rows[i]["ProductDate2"] != undefined && rows[i]["ProductDate2"] != "")
                    strProductDate2 = rows[i]["ProductDate2"];
                var strProductDate = rows[i]["ProductDate"];
                var strSegName = rows[i]["SegName"];
                var strInvCode = rows[i]["InventoryCode"];
                var strLotNoSap = rows[i]["MoBatchNo"];
                var strMold = rows[i]["Mold"];
                var strMoldGun = rows[i]["MoldGun"];
                var strMaterialLotNo = rows[i]["MaterialLotNo"];
                var strCustomerItem = rows[i]["CustomerItem"];
                var strCustomerCode = rows[i]["CustomerCode"];
                var strFinalCustomerCode = rows[i]["FinalCustomerCode"];
                var strMItemVersion = rows[i]["MItemVersion"];

                if (strLotNoSap == undefined || strLotNoSap == "")
                {
                    var postArgs = new Object();
                    postArgs["ItemName"] = strItemName;
                    postArgs["EAttribute13"] = strVendorCode;
                    postArgs["LotNo"] = strLotNo;
                    postArgs["ProductDate"] = strProductDate;
                    postArgs["ProductDate2"] = strProductDate2;
                    postArgs["SegCode"] = strSegName;
                    postArgs["InventoryCode"] = strInvCode;
                    postArgs["MItemVersion"] = strMItemVersion;
                    postArgs["Mold"] = strMold;
                    postArgs["MoldGun"] = strMoldGun;
                    postArgs["MaterialLotNo"] = strMaterialLotNo;
                    postArgs["CustomerItem"] = strCustomerItem;
                    postArgs["CustomerCode"] = strCustomerCode;
                    postArgs["FinalCustomerCode"] = strFinalCustomerCode;

                    var sUrl = "../KLabelBLL/Erp2MesLabelLotNo.aspx";
                    $.ajax({
                        type: "post",
                        url: sUrl,
                        data: postArgs,
                        async: false,
                        dataType: "xml",
                        success: function (xml)
                        {
                            var actionResult = $(xml).find("result").text();
                            if (actionResult == "fail")
                            {
                                var errMsg = $(xml).find("errormsg").text();
                                $.messager.alert("操作提示", errMsg, "error");
                                bResult = false;
                            }
                            else
                            {
                                endEditing();
                                editIndex = iRowIndex;
                                strLotNoSap = $(xml).find("lotno").text();
                                $('#gridDetail').datagrid('beginEdit', iRowIndex);
                                var edt = $('#gridDetail').datagrid('getEditor', { index: iRowIndex, field: 'MoBatchNo' });
                                edt.target.val(strLotNoSap);
                                $('#gridDetail').datagrid('endEdit', iRowIndex);
                                endEditing();
                            }
                        }
                    });
                    if (bResult == false)
                        return false;
                }
            }
            return true;
        }
        function ClearPage()
        {
            window.location.reload();
        }
//        function GoToPrintLabel()
//        {
//            if ($("#txtDeliveryBarcodeEdit").val() == "")
//                return;
//            openWindow("../KLabelBasic/FDeliveryLabelPrint.aspx?DeliveryBarcode=" + $("#txtDeliveryBarcodeEdit").val(), "标签打印（送货单）");
//        }
    </script>
    <script type="text/javascript">
        var currentEditIndex = -1;
        var currentEditLabelQty = -1;
        var currentEditPrintQty = -1;
        $.extend($.fn.datagrid.methods, {
            editCell: function (jq, param) {
                return jq.each(function () {
                    var opts = $(this).datagrid('options');
                    var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor1 = col.editor;
                        if (fields[i] != param.field) {
                            col.editor = null;
                        }
                    }
                    $(this).datagrid('beginEdit', param.index);
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor = col.editor1;
                        if (fields[i] == param.field) {
                            if (col.editor != undefined) {
                                var edt = $(this).datagrid('getEditor', { index: param.index, field: param.field });
                                if (edt != null) {
                                    edt.target.focus();
                                    edt.target.select();
                                    var keyParam =
                                    {
                                        datagrid: $(this),
                                        index: param.index,
                                        field: param.field
                                    };
                                    $(edt.target).unbind("keydown");
                                    edt.target.keydown(keyParam, function () {
                                        if (event.keyCode == 13 || event.keyCode == 9) {
                                            if (keyParam.field == "CustomerCode") {

                                                if ($('#cbxCustomerName').combobox('getValue') == "") {
                                                    $.messager.alert('提醒', '请选择客户名称！', "error", function () {
                                                        return false;
                                                    });
                                                    return false;
                                                } 
                                                var rowsTemp = $('#' + editGridId).datagrid("getRows");
                                                var rowObject = rowsTemp[keyParam.index];
                                                var edt = $(keyParam.datagrid).datagrid('getEditor', { index: param.index, field: "CustomerCode" });
                                                var strCustomerCode = edt.target.val();
                                                var strItemName = GetItemInfo(strCustomerCode).mitemname;
                                                var strItemDesc = GetItemInfo(strCustomerCode).mitemdesc;
                                                if (strItemName == "") {
                                                    $.messager.alert('提醒', '选择的客户名称不存在该客户料号！', "error");
                                                    return false;
                                                } 
                                                endEditing();
                                                editIndex = keyParam.index;
                                                $(keyParam.datagrid).datagrid('editCell', { index: keyParam.index, field: "ItemName" });
                                                edt = $(keyParam.datagrid).datagrid('getEditor', { index: param.index, field: "ItemName" });
                                                edt.target.val(strItemName);
                                                endEditing();
                                                editIndex = keyParam.index;
                                                $(keyParam.datagrid).datagrid('editCell', { index: keyParam.index, field: "EAttribute3" });
                                                edt = $(keyParam.datagrid).datagrid('getEditor', { index: param.index, field: "EAttribute3" });
                                                edt.target.val(strItemDesc);
                                                endEditing();
                                            }
                                            if (keyParam.field == "ItemName") {
                                                var rowsTemp = $('#' + editGridId).datagrid("getRows");
                                                var rowObject = rowsTemp[keyParam.index];
                                                var edt = $(keyParam.datagrid).datagrid('getEditor', { index: param.index, field: "ItemName" });
                                                var strItemName = edt.target.val();
                                                var strItemDesc = GetItemDesc(strItemName);
                                                if (strItemDesc == "") {
                                                    $.messager.alert('提醒', '没有找到此物料数据', "error");
                                                    return false;
                                                }
                                                endEditing();
                                                editIndex = keyParam.index;
                                                $(keyParam.datagrid).datagrid('editCell', { index: keyParam.index, field: "EAttribute3" });
                                                edt = $(keyParam.datagrid).datagrid('getEditor', { index: param.index, field: "EAttribute3" });
                                                edt.target.val(strItemDesc);
                                                endEditing();
                                            }

                                            endEditing();
                                            var strNextField = "";
                                            if (keyParam.field == "ItemName" || keyParam.field == "CustomerCode")
                                                strNextField = "EAttribute4";
                                            if (keyParam.field == "EAttribute4")
                                                strNextField = "LotNo";
                                            if (keyParam.field == "LotNo")
                                                strNextField = "Qty";
                                            if (keyParam.field == "TrasferQty")
                                                strNextField = "InventoryLocationOut";
                                            else if (keyParam.field == "InventoryLocationOut")
                                                strNextField = "InventoryLocationIn";

                                            if (strNextField != "") {
                                                editIndex = keyParam.index;
                                                $(keyParam.datagrid).datagrid('editCell', { index: keyParam.index, field: strNextField });
                                            }
                                            return false;
                                        }
                                    });
                                }
                            }
                        }
                    }
                });
            }
        });

        var editIndex = undefined;
        var editGridId = "";
        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#gridDetail').datagrid('validateRow', editIndex)) {
                //$('#gridQuery').datagrid('checkRow', editIndex);
                $('#gridDetail').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field)
        {
            editGridId = "gridQuery";
            if (field != "VendorLot" && field != "PODateCode" && field != "LabelPerQty" && field != "CurrentPrintQty" && field != "CurrentPrintQty" && field != "SaleOrderNo")
            {
                return true;
            }
            if (endEditing())
            {
                $('#gridQuery').datagrid('selectRow', index)
                        .datagrid('editCell', { index: index, field: field });
                editIndex = index;
            }
            return true;
        }
        function onClickCellDetail(index, field)
        {
            editGridId = "gridDetail";
            if (field != "LotNo"&&field !="EAttribute4")
            {
                return true;
            }
            if (endEditing())
            {
                $('#gridDetail').datagrid('selectRow', index)
                        .datagrid('editCell', { index: index, field: field });
                editIndex = index;
            }
            return true;
        }

        function GetItemInfo(customerCode) {
            var strItemName = "";
            var strItemDesc = "";
            var postArgs = new Object();
            postArgs["EAttribute1"] = $('#cbxCustomerName').combobox('getValue');
            postArgs["EAttribute2"] = customerCode;
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=27&OrgID=" + $("#txtCurrentOrgID").val();
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        strItemName = json.rows[0].EAttribute10;
                        strItemDesc = json.rows[0].EAttribute8;
                    }
                }
            });
            var info = { "mitemname": strItemName, "mitemdesc": strItemDesc };
            return info;
        }

        function CheckBillNoData(billCode) {
            var strResult = "Success";
            var postArgs = new Object();
            postArgs["EAttribute1"] = billCode;
            var sUrl = "../BllInvObject/QueryEntityInvObjectFromEBS.aspx?NAttribute1=47";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        strResult = "Fail";
                    }
                }
            });
            var info = { "result": strResult};
            return info;
        }

        function GetItemDesc(itemName) {
            var strItemDesc = "";
            var postArgs = new Object();
            postArgs["MItemName"] = itemName;
            postArgs["Inclusive"] = "1";
            postArgs["Exclusive"] = "1";
            var sUrl = "../BLLItem/QueryEntityMItemB.aspx";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                dataType: "json",
                async: false,
                success: function (json) {
                    if (json.total > 0) {
                        strItemDesc = json.rows[0].MItemDesc;
                    }
                }
            });
            return strItemDesc;
        }
        function ConvertPrintDateRule(rowIndex)
        {
            var rows = $("#gridDetail").datagrid("getRows");
            var rowData = rows[rowIndex];
            var postArgs = new Object();
            postArgs["SegCode"] = rowData.SegName;
            postArgs["ProductDate"] = rowData.ProductDate;
            var sUrl = "../KLabelBLL/ConvertPrintDateRule.aspx";
            var strProductDate = "";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                async: false,
                dataType: "json",
                success: function (json)
                {
                    if (json.rows != undefined && json.rows.length > 0)
                    {
                        strProductDate = json.rows[0].ProductDate2;
                        endEditing();
                        editIndex = rowIndex;
                        $('#gridDetail').datagrid('editCell', { index: rowIndex, field: "ProductDate2" });
                        edt = $('#gridDetail').datagrid('getEditor', { index: rowIndex, field: "ProductDate2" });
                        edt.target.val(strProductDate);
                        endEditing();
                    }
                }
            });
        }

        function GetInvType(invcode) {
            var invtype = "";

            var postArgs = new Object();
            postArgs["EAttribute1"] = invcode;
            postArgs["OrgID"] = $('#txtCurrentOrgID').val();
            var sUrl = "../BLLTrans/GetInventoryType.aspx?";
            $.ajax({
                type: "post",
                url: sUrl,
                data: postArgs,
                async: false,
                dataType: "xml",
                success: function (xml) {
                    var actionResult = $(xml).find("result").text();
                    if (actionResult == "success") {
                        invtype = $(xml).find("retmsg").text()
                    }
                }
            });
            return invtype;
        }

        function ImportData() {
            $.messager.progress({ title: '<%=GetLanguageString("$WebUI_PageControl_MessagerWait","请稍等") %>', msg: '<%=GetLanguageString("$WebUI_In_Loading_Data","数据加载中...") %>' });
            try {
                var strExcelContent;
                try {
                    var p = {
                        filter: "Excel File|*.xls;*.xlsx|All Files|*.*",
                        title: "Excel File"
                    };
                    var strExcelContent = window.external.ReadExcel(p);
                }
                catch (ex) {
                    alert(ex);
                    $.messager.progress('close');
                    return;
                }
                //strExcelContent = '{"status":"success","filename":"","rows":[{"客户料号":"","*物料编号":"3010010005911","物料名称":"","库位":"","批号":"CPRK201512060277","*数量":"10","采购订单号":"","供应商名称":"","生产日期":"","工单号":"","拉别":""},{"客户料号":"","*物料编号":"3010010013271","物料名称":"","库位":"","批号":"CPRK201604170115","*数量":"20","采购订单号":"","供应商名称":"","生产日期":"","工单号":"","拉别":""}]}';
                if (strExcelContent == undefined || strExcelContent == "") {
                    return;
                }
                var jsonExcel = $.parseJSON(strExcelContent);
                if (jsonExcel.status == 'fail') {
                    alert(jsonExcel.errormsg);
                    $.messager.progress('close');
                    return;
                }
                var fieldTitle = new Array();
                var fieldCode = new Array();
                var columns = $("#gridDetail").datagrid("options").columns[0];
                for (var i = 0; i < columns.length; i++) {
                    fieldTitle[i] = columns[i].title;
                    fieldCode[i] = columns[i].field;
                }
                jsonExcel.total = jsonExcel.rows.length;
                for (var i = 0; i < jsonExcel.rows.length; i++) {
                    for (var n = 0; n < fieldTitle.length; n++) {
                        if (jsonExcel.rows[i][fieldTitle[n]] != undefined) {
                            jsonExcel.rows[i][fieldCode[n]] = jsonExcel.rows[i][fieldTitle[n]];
                        }
                    }
                }
                $('#gridDetail').datagrid('loadData', jsonExcel);
            }
            catch (e) {
                alert(e);
            }
            $.messager.progress('close');
        }

    </script>
</body>
</html>
