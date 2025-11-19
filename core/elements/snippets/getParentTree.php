<?php

// Отдает родителей вверх по иерархии

return $modx->getParentIds($modx->resource->id, $depth ?: 10, [
    "context_key" => $modx->resource->context_key
]);
