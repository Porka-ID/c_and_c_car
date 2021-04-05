function c_and_c:CreateFont(name, size, weight)
    surface.CreateFont( name, {
        font = "Montserrat",
        size = size or 16,
        weight = weight or 500
    })    
end