<%@ Page Title="Proveedores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Proveedores</h1>
    <div class="mb-3">
        <%-- FILTRO RAPIDO  --%>
        <asp:Label runat="server" Text="Filtrar"></asp:Label>
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" placeholder="Buscar por NOMBRE/CUIT..." AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged"></asp:TextBox>
    </div>

    <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="false"
        CssClass="table table-striped" OnSelectedIndexChanged="gvProveedores_SelectedIndexChanged"
        DataKeyNames="Id">
        <Columns>
            <asp:BoundField HeaderText="Codigo" DataField="Codigo" />
            <asp:BoundField HeaderText="Razon Social" DataField="RazonSocial" />
            <asp:BoundField HeaderText="Cuit" DataField="Cuit" />
            <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
            <asp:BoundField HeaderText="Mail" DataField="Mail" />
            <asp:CheckBoxField HeaderText="Activo" DataField="Activo" />
            <asp:CommandField HeaderText="Acción" ShowSelectButton="true" SelectText="🖋️" />
        </Columns>
    </asp:GridView>
    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" Text=" + Agregar" CssClass="btn btn-success" OnClick="btnAgregar_Click" />
    </div>
</asp:Content>
