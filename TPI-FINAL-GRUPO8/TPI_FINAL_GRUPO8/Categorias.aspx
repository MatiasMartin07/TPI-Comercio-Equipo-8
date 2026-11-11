<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
        <h1 class="h4 mb-0">Lista de categorías</h1>
        <a href="FormCategoria.aspx" class="btn btn-primary btn-sm">+ Nueva categoría</a>
    </div>
    <asp:GridView ID="gvCategorias" runat="server"
        AutoGenerateColumns="false"
        CssClass="table table-striped align-middle"
        EmptyDataText="No hay categorías para mostrar.">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="Acciones"
                Text="Editar"
                DataNavigateUrlFields="IdCategoria"
                DataNavigateUrlFormatString="FormCategoria.aspx?id={0}"
                ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
        </Columns>
    </asp:GridView>
</asp:Content>
