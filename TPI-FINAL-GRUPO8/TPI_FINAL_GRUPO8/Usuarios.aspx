<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <asp:GridView ID="gvUsuario" runat="server" CssClass="table table-striped" AutoGenerateColumns="false"
        OnSelectedIndexChanged="gvUsuario_SelectedIndexChanged" DataKeyNames="Id"
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
