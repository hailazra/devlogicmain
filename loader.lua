-- Memuat daftar game dari GitHub
local ok, gamesOrErr = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/hailazra/devlogic/refs/heads/main/supportedgames.lua"))()
end)
if not ok then
    warn("[devlogic] gagal memuat daftar game:", gamesOrErr)
    return
end

local Games = gamesOrErr

-- Ambil URL berdasarkan PlaceId (atau Anda bisa ganti dengan game.GameId jika diperlukan)
local url = Games[game.PlaceId]
if not url then
    warn("[devlogic] Game belum didukung. PlaceId: "..tostring(game.PlaceId))
    return
end

-- Ambil sumber script dari URL
local scriptSource = game:HttpGet(url)
if not scriptSource then
    warn("[devlogic] Tidak bisa mengambil script dari "..url)
    return
end

-- Compile scriptnya
local fn, err = loadstring(scriptSource)
if not fn then
    warn("[devlogic] loadstring gagal: "..tostring(err))
    return
end

-- Jalankan script jika semuanya sukses
fn()

