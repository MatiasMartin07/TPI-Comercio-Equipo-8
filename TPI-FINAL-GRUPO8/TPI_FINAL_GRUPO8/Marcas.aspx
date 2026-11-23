<%@ Page Title="Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">

        <div>
            <h1 class="h2 fw-semibold mb-2">Marcas</h1>

            <p class="text-secondary mb-0">
                Administrá las marcas de tu catálogo
            y mantené actualizado su estado.
       
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">🏷️</span>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <a href="FormMarca.aspx" class="btn btn-primary">+ Nueva marca
    </a>
    </div>
    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <div class="row g-3 align-items-end">

            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    AssociatedControlID="txtFiltroMarca"
                    CssClass="form-label"
                    Text="Buscar marca" />

                <asp:TextBox ID="txtFiltroMarca" runat="server"
                    CssClass="form-control"
                    Style="max-width: none;"
                    placeholder="Nombre de la marca"
                    AutoPostBack="true"
                    OnTextChanged="txtFiltroMarca_TextChanged" />
            </div>

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    AssociatedControlID="ddlEstadoMarca"
                    CssClass="form-label"
                    Text="Estado" />

                <asp:DropDownList ID="ddlEstadoMarca" runat="server"
                    CssClass="form-select"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstadoMarca_SelectedIndexChanged">

                    <asp:ListItem Text="Todos" Value="todos" />
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                </asp:DropDownList>
            </div>

        </div>
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
                            NavigateUrl='<%# Eval("IdMarca", "FormMarca.aspx?id={0}") %>'
                            CssClass="btn btn-outline-primary btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
