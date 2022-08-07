{% macro render_constructor(spec) -%}

{% for constructor in spec.constructors %}
# {{ constructor.index }} {{ constructor.arguments }}
{% endfor %}

{% if spec.name == "Vector2" %}

def __cinit__({{ spec.name }} self, x=None, y=None):
    cdef GDNativeTypePtr args[2]
    cdef float args_x
    cdef float args_y
    if y is None:
        if x is None:
            __{{ spec.name }}_constructor_0(self._gd_data, NULL)
            return

        try:
            args[0] = (<Vector2>x)._gd_data
        except TypeError:

            try:
                args[0] = (<Vector2i>x)._gd_data
            except TypeError:
                pass

            else:
                # Constructor from Vector2i
                __{{ spec.name }}_constructor_2(self._gd_data, args)
                return

        else:
            # Constructor from Vector2
            __{{ spec.name }}_constructor_1(self._gd_data, args)
            return

    elif isinstance(x, (float, int)) and isinstance(y, (float, int)):
        args_x = x
        args_y = y
        args[0] = &args_x
        args[1] = &args_y
        __{{ spec.name }}_constructor_3(self._gd_data, args)
        return

    raise TypeError(f"Expected x&y as int/float, or x as Vector2/Vector2i")

{% else %}

def __cinit__({{ spec.name }} self):
    __{{ spec.name }}_constructor_0(self._gd_data, NULL)

{% endif %}

{% endmacro %}
