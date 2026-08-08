if (surface_exists(surf))
{
    // Desenha a Tile Layer na Surface
    surface_set_target(surf);

    draw_clear_alpha(c_black, 0);

    draw_tilemap(tilemap_id, 0, 0);

    surface_reset_target();


    // Abre "Salvar como..."
    var arquivo = get_save_filename(
        "PNG Image|*.png",
        "tile_layer.png"
    );


    // Usuário não cancelou
    if (arquivo != "")
    {
        surface_save(surf, arquivo);

        show_debug_message("PNG salvo em:");
        show_debug_message(arquivo);

        surface_free(surf);
        surf = -1;

        instance_destroy();
    }
}