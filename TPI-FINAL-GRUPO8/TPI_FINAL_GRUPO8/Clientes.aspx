<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="text-center">Lista de Clientes</h2>
    <div class="mb-3">
        <%-- FILTRO RAPIDO  --%>
        <asp:Label runat="server" Text="Filtrar"></asp:Label>
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" placeholder="Buscar por DNI/CUIT..." AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged"></asp:TextBox>
    </div>

    <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="false" 
                CssClass="table table-striped" OnSelectedIndexChanged="gvClientes_SelectedIndexChanged"
                DataKeyNames="Id"
        >
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
