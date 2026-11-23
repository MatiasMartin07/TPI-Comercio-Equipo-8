<%@ Page Title="Categorías" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">

        <div>
            <h1 class="h2 fw-semibold mb-2">Categorías</h1>

            <p class="text-secondary mb-0">
                Organizá los productos de tu catálogo
            y administrá sus categorías.
       
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">🗂️</span>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <a href="FormCategoria.aspx" class="btn btn-primary">+ Nueva categoría
    </a>
    </div>
    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <div class="row g-3 align-items-end">

            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    AssociatedControlID="txtFiltroCategoria"
                    CssClass="form-label"
                    Text="Buscar categoría" />

                <asp:TextBox ID="txtFiltroCategoria" runat="server"
                    CssClass="form-control"
                    Style="max-width: none;"
                    placeholder="Nombre de la categoría"
                    AutoPostBack="true"
                    OnTextChanged="txtFiltroCategoria_TextChanged" />
            </div>

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    AssociatedControlID="ddlEstadoCategoria"
                    CssClass="form-label"
                    Text="Estado" />

                <asp:DropDownList ID="ddlEstadoCategoria" runat="server"
                    CssClass="form-select"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstadoCategoria_SelectedIndexChanged">

                    <asp:ListItem Text="Todos" Value="todos" />
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                </asp:DropDownList>
            </div>

        </div>
    </div>
    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvCategorias" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            EmptyDataText="No hay categorías para mostrar.">
            <EmptyDataRowStyle CssClass="listado-sin-resultados" />
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:TemplateField HeaderText="Estado">
                    <ItemTemplate>
                        <span class='<%# (bool)Eval("Activo")
            ? "badge bg-success bg-opacity-10 text-success px-2 py-2"
            : "badge bg-secondary bg-opacity-10 text-secondary px-2 py-2" %>'>

                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkEditar" runat="server"
                            Text="Editar"
                            NavigateUrl='<%# Eval("IdCategoria", "FormCategoria.aspx?id={0}") %>'
                            CssClass="btn btn-outline-primary btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
