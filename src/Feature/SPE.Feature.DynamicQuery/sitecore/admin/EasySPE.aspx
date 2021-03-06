<%@ Language="C#"%>

<!DOCTYPE html>
<%@ Import  Namespace="Sitecore.Configuration"%>
<%@ Import  Namespace="Sitecore.Data"%>
<%@ Import  Namespace="Sitecore.Data.Items" %>

<html xmlns="http://www.w3.org/1999/xhtml">
   <script runat="server" language="C#">

       void Page_Load(object sender, EventArgs e)
       {
           queryOutput.Value = string.Empty;
           if (!IsPostBack)
           {
               Database database = Factory.GetDatabase("master");
               //Item Root
               Item rootItem = database.GetItem("/sitecore/content/Home/");
               foreach (Item eachItem in rootItem.Children)
               {
                   MyRootPath.Items.Add(new ListItem(eachItem.Paths.Path.ToString().ToLower(),eachItem.ID.ToString()));
               }
               // Template
               Item templateRootItem = database.GetItem("/sitecore/templates/Feature/");
               foreach (Item eachItem in templateRootItem.Children)
               {
                   MyTemplateRootPath.Items.Add(new ListItem(eachItem.Paths.Path.ToString().ToLower(),eachItem.ID.ToString()));
               }
           }
       }
       public void btnBuildQuery_Click(Object sender, EventArgs e)
       {
           StringBuilder sb;
           switch (rbtnAction.SelectedValue.ToLowerInvariant())
           {
               case "create" :
                   sb = new StringBuilder();
                   sb.AppendLine("$InputCount = \""+txtFieldCount.Text+"\" ");
                   sb.AppendLine("$InputTemplate = \"" + MyTemplateRootPath.SelectedItem.Text + "\"    ");
                   sb.AppendLine("$getCurrentItem = \"" + MyRootPath.SelectedItem.Text + "\"");
                   sb.AppendLine("$NewItemPath = $getCurrentItem");
                   sb.AppendLine("$CurrentChildCount = $getCurrentItem.Children.Count+1");
                   sb.AppendLine("for ($index = $CurrentChildCount; $index -lt $CurrentChildCount +$InputCount; $index++)");
                   sb.AppendLine("{" + "\n" + "new-item -Path $NewItemPath -Name \"$index\" -type $InputTemplate" + "\n" +"}");
                   queryOutput.Value = sb.ToString();
                   break;
               case "delete":
                   sb = new StringBuilder();
                   sb.AppendLine("$contentPath = \"master:"+MyRootPath.SelectedItem.Text+"" + "/\"" );
                   sb.AppendLine("$templateID = \""+MyTemplateRootPath.SelectedValue+"\"");
                   sb.AppendLine("$fieldName = \"" + txtFieldName.Text +"\"");
                   sb.AppendLine("$newFieldValue = \"" + txtFieldValue.Text +"\"");
                   sb.AppendLine("$items = Get-ChildItem -Path $contentPath `");
                   sb.AppendLine("\t" + "-Recurse |" +"\n" + "\t"+ "Where-Object {");
                   sb.AppendLine("\t"+"($_.\"TemplateID\" -eq $templateID)"+ "\n"+ "\t"+"}");
                   sb.AppendLine(" foreach ($i in $items){");
                   sb.AppendLine("\t"+"$i | Remove-Item");
                   sb.AppendLine("}");
                   queryOutput.Value = sb.ToString();
                   break;
               case "update":
                   sb = new StringBuilder();
                   sb.AppendLine("$contentPath = \"master:"+MyRootPath.SelectedItem.Text+"" + "/\"" );
                   sb.AppendLine("$templateID = \""+MyTemplateRootPath.SelectedValue+"\"");
                   sb.AppendLine("$fieldName = \"" + txtFieldName.Text +"\"");
                   sb.AppendLine("$newFieldValue = \"" + txtFieldValue.Text +"\"");
                   sb.AppendLine("$items = Get-ChildItem -Path $contentPath ` ");
                   sb.AppendLine("-Recurse |" + "\n" + "Where-Object {");
                   sb.AppendLine("\t" + "($_.\"TemplateID\" -eq $templateID)" + "\n" + "}");
                   sb.AppendLine(" foreach ($i in $items){");
                   sb.AppendLine("\t" + "$i.Editing.BeginEdit()");
                   sb.AppendLine("$i.Fields[$fieldName].Value = $newFieldValue");
                   sb.AppendLine("$i.Editing.EndEdit()"+" }");
                   queryOutput.Value = sb.ToString();
                   break;
               case "search":
                   sb = new StringBuilder();
                   sb.AppendLine("$templateName = \"" + MyTemplateRootPath.SelectedValue + "\"");
                   sb.AppendLine("$props = @{");
                   sb.AppendLine("\t"+ "Title = \"Detailed Report\"");
                   sb.AppendLine("\t"+ "Description = \"Lists all page items based upon the condition.\"");
                   sb.AppendLine("\t"+ "OkButtonName = \"Run Report\"");
                   sb.AppendLine("\t"+ "CancelButtonName = \"Cancel\"");
                   sb.AppendLine("\t"+ "Parameters = @(");
                   sb.AppendLine("\t"+ "@{ Name = \"renderingRoot\"; Title = \"Siteroot Folder\"; Editor = \"droptree\"; Source = \""+MyRootPath.SelectedItem.Text+ "\" }"+"\n"+")}");
                   // sb.AppendLine("\t" + ")");
                   sb.AppendLine("$result = Read-Variable @props");
                   sb.AppendLine("if($result -ne \"ok\") {" + "\n\t\t"+ "Close-Window" +"\n\t"+ "Exit" + "\n"+"}");
                   sb.AppendLine("# PROCESS");
                   sb.AppendLine("$dbPath = 'master://'");
                   sb.AppendLine("$output = @()");
                   sb.AppendLine("# Get all rendering items under the given folder");
                   sb.AppendLine("$allTargetRenderings = Get-ChildItem master: -ID $renderingRoot.ID -Recurse | Where-Object { $_.TemplateID -eq $templateName }");
                   sb.AppendLine("# For each rendering, get all referrers where the Template is like 'SiteBase' (ideally gives us page items only)");
                   sb.AppendLine("\t"+ "ForEach ($rendering in $allTargetRenderings) {");
                   sb.AppendLine(" $output += New-Object PSObject @{ ItemId = $rendering.ID; ItemName = $rendering.Name; PagePath = $rendering.FullPath }}");
                   sb.AppendLine("$output | Show-ListView -Property `");
                   sb.AppendLine("@{ Name = \"ID\"; Expression = { $_.ItemId } },");
                   sb.AppendLine("@{ Name = \"Name\"; Expression = { $_.ItemName } },");
                   sb.AppendLine("@{ Name = \"Path\"; Expression = { $_.PagePath } }");
                   queryOutput.Value = sb.ToString();
                   break;
           }
       }

   </script>
<head runat="server">
    <title>Dynamic SPE Query</title>
    <link href="/style/SPEStyle.css" rel="stylesheet" />
    
    <script src="/style/jquery-3.5.1.min.js"></script>
    <script src="/style/jquery.min.js"></script>
    <link href="/style/bootstrap.min.css" rel="stylesheet" />
    <link href="/style/font-awesome.min.css" rel="stylesheet" />
    <script src="/style/bootstrap.min.js"></script>
    <link href="/style/SPEStyle2.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container">
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <div id="exTab1" class="">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#2a" data-toggle="tab">Query Builder</a>
                </li>
                <li><a href="#3a" data-toggle="tab">Query Exceution</a>
                </li>
                <li><a href="#4a" data-toggle="tab">Report Configuration</a>
                </li>
            </ul>
            <div class="tab-content clearfix">
                <div class="tab-pane active" id="2a">
                    <h3 class="h3-lessmarigin">Query Builder tab</h3>
                    <%--radio button group--%>
                    <div class="alignformFields">
                        <div class="rowmarigin">
                            <asp:RadioButtonList ID="rbtnAction" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                <asp:ListItem Value="create" class="col-md-3">Create</asp:ListItem>
                                <asp:ListItem Value="delete" class="col-md-3">Delete</asp:ListItem>
                                <asp:ListItem Value="update" class="col-md-3">Update</asp:ListItem>
                                <asp:ListItem Value="search" class="col-md-3">Search</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div class="txtRootPathDiv form-group row rowmarigin">
                            <asp:Label ID="lblRootPath" runat="server" Text="Sitecore Root Path" class="col-md-2 col-form-label"></asp:Label>
                            <div class="col-md-10 rowmarigin">
                                <asp:DropDownList ID="MyRootPath" CssClass="form-control" runat="server"></asp:DropDownList><br />
                            </div>
                        </div>

                        <div class="ddlTemplateDiv form-group row rowmarigin">
                            <asp:Label ID="Label4" runat="server" Text="Select Template" class="col-md-2 col-form-label padding-adjuster"></asp:Label>
                            <div class="col-md-10 rowmarigin">
                                <asp:DropDownList ID="MyTemplateRootPath" runat="server" class="btn btn-secondary dropdown-toggle form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="txtFieldCountDiv row">
                            <asp:Label ID="lblFieldCount" runat="server" Text="No of Items to be created :" class="col-md-3 col-form-label"></asp:Label>
                            <div class="col-md-1">
                                <asp:TextBox ID="txtFieldCount" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <asp:Label ID="lblFieldName" runat="server" Text="Field Name :" class="col-md-2 col-form-label col-form-label padding-adjuster .marigin-adjuster"></asp:Label>
                            <div class="col-md-2">
                                <asp:TextBox ID="txtFieldName" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <asp:Label ID="lblFieldValue" runat="server" Text="Field Value :" class="col-md-2 col-form-label  col-form-label padding-adjuster .marigin-adjuster"></asp:Label>
                            <div class="col-md-2">
                                <asp:TextBox ID="txtFieldValue" class="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:Button ID="btnBuildQuery" style="margin-top: 5px;" runat="server" OnClick="btnBuildQuery_Click" Text="Build SPE Query" class="btnBuildSpeQuery btn btn-primary" />
                    </div>
                    <div style="margin-top: -16px;">
                        <textarea id="queryOutput" cols="20" rows="2" runat="server" value=""></textarea>
                    </div>
                </div>

                <div class="tab-pane" id="3a">
                    <h3>Query Exceution tab</h3>

                </div>
                <div class="tab-pane" id="4a">
                    <h3>Report Configuration tab</h3>
                </div>
            </div>
        </div>

    </form>
</body>
</html>

