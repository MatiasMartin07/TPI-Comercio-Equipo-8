<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Proveedores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Proveedores</h1>
    <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="false" CssClass="table table-striped">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="Codigo" HeaderText="Código" />
            <asp:BoundField DataField="RazonSocial" HeaderText="Razón Social" />
            <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
        </Columns>
    </asp:GridView>
</asp:Content>
