<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">
        <div>
            <h1 class="h2 fw-semibold mb-2">Clientes</h1>
            <p class="text-secondary mb-0">
                Consultá y administrá los clientes registrados.
       
            </p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">👥</span>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <asp:Button ID="btnAgregar" runat="server"
            Text="+ Nuevo cliente"
            CssClass="btn btn-primary"
            OnClick="btnAgregar_Click" />
    </div>

    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <div class="row g-3 align-items-end">
            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    Text="Buscar cliente"
                    AssociatedControlID="txtFiltro"
                    CssClass="form-label" />

                <asp:TextBox ID="txtFiltro" runat="server"
                    CssClass="form-control"
                    Style="max-width: none;"
                    placeholder="Buscar por DNI/CUIT o nombre"
                    AutoPostBack="true"
                    OnTextChanged="txtFiltro_TextChanged" />
            </div>

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    Text="Estado"
                    AssociatedControlID="ddlEstadoCliente"
                    CssClass="form-label" />

                <asp:DropDownList ID="ddlEstadoCliente" runat="server"
                    CssClass="form-select"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstadoCliente_SelectedIndexChanged">
                    <asp:ListItem Text="Todos" Value="Todos" />
                    <asp:ListItem Text="Activos" Value="Activos" />
                    <asp:ListItem Text="Inactivos" Value="Inactivos" />
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvClientes" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            OnSelectedIndexChanged="gvClientes_SelectedIndexChanged"
            DataKeyNames="Id"
            EmptyDataText="No hay clientes para mostrar.">

            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                <asp:BoundField HeaderText="DNI" DataField="Dni" />
                <asp:CheckBoxField HeaderText="Activo" DataField="Activo" />
                <asp:CommandField HeaderText="Acción"
                    ShowSelectButton="true"
                    SelectText="Editar" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
