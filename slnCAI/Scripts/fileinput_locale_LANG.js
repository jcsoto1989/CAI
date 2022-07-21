/*!
 * FileInput <_LANG_> Translations
 *
 * This file must be loaded after 'fileinput.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * @see http://github.com/kartik-v/bootstrap-fileinput
 *
 * NOTE: this file must be saved in UTF-8 encoding.
 */
(function ($) {
    "use strict";

    $.fn.fileinput.locales._LANG_ = {
        fileSingle: 'archivo',
        filePlural: 'archivos',
        browseLabel: 'Buscar&hellip;',
        removeLabel: 'Remover',
        removeTitle: 'Limpiar archivos seleccionados',
        cancelLabel: 'Cancelar',
        cancelTitle: 'Abortar el cargue en curso',
        uploadLabel: 'Cargar Archivo',
        uploadTitle: 'Cargar archivos seleccionados',
        msgSizeTooLarge: 'Archivo "{name}" (<b>{size} KB</b>) excede el tama�o m�ximo permitido de <b>{maxSize} KB</b>. Por favor reintente su cargue!',
        msgFilesTooLess: 'Usted debe seleccionar al menos <b>{n}</b> {files} a cargar. Por favor reintente su cargue!',
        msgFilesTooMany: 'El n�mero de archivos seleccionados a cargar <b>({n})</b> excede el l�mite m�ximo permitido de <b>{m}</b>. Por favor reintente su cargue!',
        msgFileNotFound: 'Archivo "{name}" no encontrado!',
        msgFileSecured: 'Restricciones de seguridad previenen la lectura del archivo "{name}".',
        msgFileNotReadable: 'Archivo "{name}" no se puede leer.',
        msgFilePreviewAborted: 'Previsualizaci�n del archivo abortada para "{name}".',
        msgFilePreviewError: 'Ocurri� un error mientras se le�a el archivo "{name}".',
        msgInvalidFileType: 'Tipo de archivo inv�lido para el archivo "{name}". S�lo archivos "{types}" son permitidos.',
        msgInvalidFileExtension: 'Extensi�n de archivo inv�lido para "{name}". S�lo archivos "{extensions}" son permitidos.',
        msgValidationError: 'Error Cargando Archivo',
        msgLoading: 'Cargando archivo {index} of {files} &hellip;',
        msgProgress: 'Cargando archivo {index} of {files} - {name} - {percent}% completado.',
        msgSelected: '{n} archivos seleccionados',
        msgFoldersNotAllowed: 'Arrastre y suelte �nicamente archivos! Se omite {n} carpeta(s).',
        dropZoneTitle: 'Arrastre y suelte los archivos aqu&iacute&hellip;'
    };

    $.extend($.fn.fileinput.defaults, $.fn.fileinput.locales._LANG_);
})(window.jQuery);