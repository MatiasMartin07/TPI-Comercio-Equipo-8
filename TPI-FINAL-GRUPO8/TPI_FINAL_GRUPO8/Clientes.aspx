<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<h2 class="text-center" style="color: #6ea8fe;">Lista de Clientes</h2>

<div class="mb-3">
    <asp:Label runat="server" Text="Buscar" AssociatedControlID="txtFiltro" CssClass="form-label"></asp:Label>
    <div class="d-flex align-items-end gap-2">
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control flex-grow-1" placeholder="Buscar por DNI/CUIT o Nombre" AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged"></asp:TextBox>

        <asp:DropDownList ID="ddlEstadoCliente" runat="server" CssClass="form-select" Style="max-width: 150px;" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoCliente_SelectedIndexChanged">
            <asp:ListItem Text="Todos" Value="Todos" />
            <asp:ListItem Text="Activos" Value="Activos" />
            <asp:ListItem Text="Inactivos" Value="Inactivos" />
        </asp:DropDownList>
    </div>
</div>
    <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="false"
        CssClass="table table-striped" OnSelectedIndexChanged="gvClientes_SelectedIndexChanged"
        DataKeyNames="Id" EmptyDataText="No hay Clientes para mostrar " >
        <Columns>
            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
            <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
            <asp:BoundField HeaderText="DNI" DataField="Dni" />
            <asp:CheckBoxField HeaderText="Activo" DataField="Activo" />
            <asp:CommandField HeaderText="Acción" ShowSelectButton="true" SelectText="🖋️" />
        </Columns>
    </asp:GridView>
    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" Text=" + Agregar" CssClass="btn btn-success" OnClick="btnAgregar_Click" />
    </div>


</asp:Content>
