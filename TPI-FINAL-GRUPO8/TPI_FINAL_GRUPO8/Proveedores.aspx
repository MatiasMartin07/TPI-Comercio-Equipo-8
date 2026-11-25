<%@ Page Title="Proveedores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">
        <div>
            <h1 class="h2 fw-semibold mb-2">Proveedores</h1>
            <p class="text-secondary mb-0">
                Administra tus proveedores y consulta sus datos.       
            </p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">&#128666;</span>
    </div>
    <div class="d-flex justify-content-end mb-3">
        <asp:Button ID="btnAgregar" runat="server" Text="+ Nuevo proveedor" CssClass="btn btn-primary" OnClick="btnAgregar_Click" />
    </div>
    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <asp:Label runat="server"
            AssociatedControlID="txtFiltro"
            CssClass="form-label"
            Text="Filtrar proveedores" />

        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" Style="max-width: none;" placeholder="Buscar por nombre o CUIT..." AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged" />
    </div>

    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvProveedores" runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-striped align-middle"
            OnSelectedIndexChanged="gvProveedores_SelectedIndexChanged"
            DataKeyNames="Id">
            <Columns>
                <asp:BoundField HeaderText="Codigo" DataField="Codigo" />
                <asp:BoundField HeaderText="Razon Social" DataField="RazonSocial" />
                <asp:BoundField HeaderText="Cuit" DataField="Cuit" />
                <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
                <asp:BoundField HeaderText="Mail" DataField="Mail" />
                <asp:CheckBoxField HeaderText="Activo" DataField="Activo" />
                <asp:CommandField HeaderText="Accion" ShowSelectButton="true" SelectText="Editar" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
