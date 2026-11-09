using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;

namespace TPI_FINAL_GRUPO8
{
    public partial class FormUsuario : System.Web.UI.Page
    {
        public bool confirmar { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            confirmar = false;

            if (!IsPostBack)
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "")
                {
                    UsuarioNegocio negocio = new UsuarioNegocio();
                    Usuario seleccionado = negocio.listarUsuarioId(id);
                    Session.Add("usuarioSeleccionado", seleccionado);

                    txtId.Text= id;
                    txtNombre.Text = seleccionado.Nombre;
                    txtApellido.Text = seleccionado.Apellido;
                    txtNombreUsuario.Text = seleccionado.NombreUsuario;
                    txtPass.Text = seleccionado.Pass;
                    ddlRol.Text = seleccionado.Rol;

                    if (!seleccionado.Activo)
                    {
                        btnInactivar.Text = "Reactivar";
                    }

                }
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario nuevo = new Usuario();
                UsuarioNegocio negocio = new UsuarioNegocio();

                int idUsuario = 0;
                if (Request.QueryString["id"] != null)
                {
                    idUsuario = int.Parse(Request.QueryString["id"].ToString());
                    nuevo.Id = idUsuario;
                }
                else
                {
                    nuevo.Id = 0; 
                }
                if (string.IsNullOrEmpty(txtNombre.Text))
                {
                    lblErrorNombre.Text = "Ingrese un Nombre";
                    txtNombre.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                nuevo.Nombre = txtNombre.Text;

                if (string.IsNullOrEmpty(txtApellido.Text))
                {
                    lblErrorApellido.Text = "Ingrese un Apellido";
                    txtApellido.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                nuevo.Apellido = txtApellido.Text;

                if (string.IsNullOrEmpty(txtNombreUsuario.Text))
                {
                    lblNUError.Text = "Ingrese un Numero de Usuario";
                    txtNombreUsuario.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    if (negocio.existeUsuario(txtNombreUsuario.Text, nuevo.Id))
                    {
                        lblNUError.Text = "Ya existe este Nombre de Usuario, vuelva a intentar";
                        txtNombreUsuario.BorderColor = System.Drawing.Color.Red;
                        return;
                    }                    
                    txtNombreUsuario.BorderColor = System.Drawing.Color.Empty;
                    lblNUError.Text = "";
                }


                nuevo.NombreUsuario = txtNombreUsuario.Text;

                if (string.IsNullOrEmpty(txtPass.Text))
                {
                    lblPassError.Text = "Ingrese una contraseña";
                    txtPass.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                nuevo.Pass = txtPass.Text;
                nuevo.Rol = ddlRol.Text;
                nuevo.Activo = true;

                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(txtId.Text);
                    negocio.modificar(nuevo);
                }
                else
                {
                    negocio.agregarUsuario(nuevo);
                }
                Response.Redirect("Usuarios.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void btnInactivar_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                Usuario seleccionado = (Usuario)Session["usuarioSeleccionado"];
                negocio.eliminarLogico(seleccionado.Id, !seleccionado.Activo);
                Response.Redirect("Usuarios.aspx", false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            confirmar = true;
        }

        protected void btnConfirma_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbcConfirma.Checked)
                {
                    UsuarioNegocio negocio = new UsuarioNegocio();
                    negocio.eliminar(int.Parse(txtId.Text));
                    Response.Redirect("Usuarios.aspx", false);
                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void txtNombre_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombre.Text))
            {
                lblErrorNombre.Text = string.Empty;
                txtNombre.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtApellido_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtApellido.Text))
            {
                lblErrorApellido.Text = string.Empty;
                txtApellido.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtNombreUsuario_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtApellido.Text))
            {
                lblNUError.Text = string.Empty;
                txtNombreUsuario.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtPass_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtPass.Text))
            {
                lblPassError.Text = string.Empty;
                txtPass.BorderColor = System.Drawing.Color.Gray;
            }
        }


    }
}