<%@ Page Title="Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Lista de marcas</h1>
    <div class="d-flex justify-content-end mb-3">
        <a href="FormMarca.aspx" class="btn btn-primary">Nueva marca</a>
    </div>
    <asp:GridView ID="gvMarcas" runat="server"
        AutoGenerateColumns="false"
        ShowHeaderWhenEmpty="true"
        CssClass="table table-striped"
        EmptyDataText="No hay marcas para mostrar.">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="Acción"
                Text="Editar"
                DataNavigateUrlFields="IdMarca"
                DataNavigateUrlFormatString="FormMarca.aspx?id={0}"
                ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
        </Columns>
    </asp:GridView>
</asp:Content>
