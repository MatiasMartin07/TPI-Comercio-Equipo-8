<%@ Page Title="Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
        <h1 class="h4 mb-0">Lista de marcas</h1>
        <a href="FormMarca.aspx" class="btn btn-primary btn-sm">+ Nueva marca</a>
    </div>
    <div class="d-flex flex-wrap align-items-center gap-2 border border-bottom-0 bg-white px-3 py-2">
        <asp:Label runat="server" AssociatedControlID="txtFiltroMarca"
            CssClass="visually-hidden" Text="Buscar por nombre" />
        <asp:TextBox ID="txtFiltroMarca" runat="server"
            CssClass="form-control form-control-sm"
            Style="max-width: 240px;"
            placeholder="Buscar por nombre"
            AutoPostBack="true"
            OnTextChanged="txtFiltroMarca_TextChanged" />

        <asp:Label runat="server" AssociatedControlID="ddlEstadoMarca"
            CssClass="visually-hidden" Text="Filtrar por estado" />
        <asp:DropDownList ID="ddlEstadoMarca" runat="server"
            CssClass="form-select form-select-sm"
            Style="max-width: 150px;"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlEstadoMarca_SelectedIndexChanged">
            <asp:ListItem Text="Todos" Value="todos" />
            <asp:ListItem Text="Activos" Value="activos" />
            <asp:ListItem Text="Inactivos" Value="inactivos" />
        </asp:DropDownList>
    </div>
    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvMarcas" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            EmptyDataText="No hay marcas para mostrar.">
            <EmptyDataRowStyle CssClass="listado-sin-resultados" />
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:TemplateField HeaderText="Estado">
                    <ItemTemplate>
                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkEditar" runat="server"
                            Text="Editar"
                            NavigateUrl='<%# Eval("IdMarca", "FormMarca.aspx?id={0}") %>'
                            CssClass="btn btn-outline-primary btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
