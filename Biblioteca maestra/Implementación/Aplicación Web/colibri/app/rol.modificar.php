<!DOCTYPE html>

<?php
include_once '../lib/ControlAcceso.Class.php';
ControlAcceso::requierePermiso(PermisosSistema::PERMISO_ROLES);

include_once '../modelo/Rol.Class.php';
include_once '../modelo/ColeccionPermisos.php';

$id = $_GET["id"];

if ($id == PermisosSistema::IDROL_PUBLICO_GENERAL) {
    /* El rol "Público general" no debe ser modificado. */
    ControlAcceso::redireccionar("roles.php");
    
    exit();
}

$Rol = new Rol($id);
$PermisosSistema = new ColeccionPermisos();
?>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../lib/bootstrap-4.1.1-dist/css/bootstrap.css" />
        <link rel="stylesheet" href="../lib/open-iconic-master/font/css/open-iconic-bootstrap.css" />
        <script type="text/javascript" src="../lib/JQuery/jquery-3.3.1.js"></script>
        <script type="text/javascript" src="../lib/bootstrap-4.1.1-dist/js/bootstrap.min.js"></script>
        <title><?php echo Constantes::NOMBRE_SISTEMA; ?> - Actualizar Rol</title>

    </head>
    <body>
        <?php include_once '../gui/navbar.php'; ?>
        <div class="container">
            <form action="rol.modificar.procesar.php" method="post">
                <div class="card">
                    <div class="card-header">
                        <h3>Actualizar Rol</h3>
                        <p>
                            Complete los campos a continuación. 
                            Luego, presione el botón <strong>Confirmar</strong>.<br />
                            Si desea cancelar, presione el botón <strong>Cancelar</strong>.
                        </p>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="inputNombre">Nombre</label>
                            <input type="text" name="nombre" class="form-control" id="inputNombre" value="<?= $Rol->getNombre(); ?>" placeholder="Ingrese el nombre del Rol" required="">
                        </div>
                        <input type="hidden" name="id" class="form-control" id="id" value="<?= $Rol->getId(); ?>" >
                        <hr />
                        <h3>Permisos</h3>
                        <?php foreach ($PermisosSistema->getPermisos() as $PermisoSistema) {
                            ?>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" 
                                       id="permiso[<?= $PermisoSistema->getId(); ?>]" name="permiso[<?= $PermisoSistema->getId(); ?>]"
                                       value="<?= $PermisoSistema->getId(); ?>" 
                                       <?php echo $Rol->buscarPermisoPorId($PermisoSistema->getId()) ? "checked" : ""; ?> 
                                       />
                                <label class="form-check-label" for="rol">

                                    <?= $PermisoSistema->getNombre(); ?>

                                </label>
                            </div>
                        <?php } ?>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-outline-success">
                            <span class="oi oi-check"></span> Confirmar
                        </button>
                        <a class="btn btn-outline-danger" href="roles.php">
                            <span class="oi oi-x"></span> Cancelar
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <?php include_once '../gui/footer.php'; ?>
    </body>
</html>