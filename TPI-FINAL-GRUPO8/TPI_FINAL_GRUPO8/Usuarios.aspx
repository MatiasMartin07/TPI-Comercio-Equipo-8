<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="text-center" style="color: #6ea8fe;">Lista de Usuarios</h2>

    <div class="mb-3">
    <asp:Label runat="server" Text="Buscar" AssociatedControlID="txtFiltro" CssClass="form-label"></asp:Label>
    <div class="d-flex align-items-end gap-2">
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control flex-grow-1" placeholder="Buscar por Administrador o Vendedor" AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged"></asp:TextBox>

        <asp:DropDownList ID="ddlEstadoUsuario" runat="server" CssClass="form-select" Style="max-width: 150px;" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoCliente_SelectedIndexChanged">
            <asp:ListItem Text="Todos" Value="Todos" />
            <asp:ListItem Text="Activos" Value="Activos" />
            <asp:ListItem Text="Inactivos" Value="Inactivos" />
        </asp:DropDownList>
    </div>
  </div>

    <asp:GridView ID="gvUsuario" runat="server" CssClass="table table-striped" AutoGenerateColumns="false"
        OnSelectedIndexChanged="gvUsuario_SelectedIndexChanged" DataKeyNames="Id" EmptyDataText="No hay usuarios para mostrar"
        >
        <Columns>
            <asp:BoundField HeaderText="Usuario" DataField="NombreUsuario" />
            <asp:BoundField HeaderText="Rol" DataField="Rol" />
            <asp:CheckBoxField HeaderText="Estado" DataField="Activo" />
            <asp:CommandField HeaderText="Acción" ShowSelectButton="true" SelectText="🖋️" />
        </Columns>
    </asp:GridView>
    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-success" OnClick="btnAgregar_Click"/>
    </div>

</asp:Content>
