using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtUsuario_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtUsuario.Text))
            {
                lblError.Text = string.Empty;
                txtUsuario.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                //validacion
                if (string.IsNullOrEmpty(txtUsuario.Text) || string.IsNullOrEmpty(txtPass.Text))
                {
                    lblError.Text = "Debe ingresar usuario y contraseña";
                    txtUsuario.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                UsuarioNegocio negocio = new UsuarioNegocio();
                Usuario usuario = new Usuario();
                usuario = negocio.loguear(txtUsuario.Text, txtPass.Text);

                if(usuario == null)
                {
                    lblError.Text = "Usuario o Contraseña incorrecta";
                    txtUsuario.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                if (!usuario.Activo)
                {
                    lblError.Text = "El usuario esta Inactivo";
                    txtUsuario.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                Session["usuarioLogueado"] = usuario;

                if (usuario.Rol == "Administrador")
                {
                    Response.Redirect("Inicio.aspx", false);

                }
                else if (usuario.Rol == "Vendedor")
                {
                    Response.Redirect("Inicio.aspx", false);
                }
                else
                {
                    lblError.Text = "Rol sin permisos asignados";
                    return;
                }

            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }
}