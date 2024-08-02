// Made by camelCase
//

function Run_Console(com,num)
    RunConsoleCommand(com,num)
end

function camelCaseEnableMulticore()
    Run_Console('gmod_mcore_test','1')
    Run_Console('mat_queue_mode','-1')
    Run_Console('cl_threaded_bone_setup','1')
end

function camelCaseDisableMulticore()
    Run_Console('gmod_mcore_test','0')
    Run_Console('mat_queue_mode','-1')
    Run_Console('cl_threaded_bone_setup','0')
end

local function OpenWindow()
    local D_Frame = vgui.Create('DFrame')
    D_Frame:SetTitle('')
    D_Frame:SetSize(400,200)
    D_Frame:Center()
    D_Frame:MakePopup()
    D_Frame:ShowCloseButton(true)
    function D_Frame.Paint(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0))
    end

    local Panel = vgui.Create('DPanel',D_Frame)
    Panel:SetPaintBackground(true)
    Panel:SetSize(400,50)
    Panel:Dock(BOTTOM)
    Panel:DockMargin(0,0,0,0)
    function Panel:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,color_black)
    end

    local Title = vgui.Create("DLabel", D_Frame)
    Title:SetText("Enable Multicore Rendering?")
    Title:SetFont("DermaLarge")
    Title:Center()
    Title:SetTextColor( Color(255, 255, 255) )
    Title:SetContentAlignment(8)
    Title:Dock(FILL)
    
    local Boost = vgui.Create("DLabel", D_Frame)
    Boost:SetText("Boost FPS!")
    Boost:SetFont("DermaLarge")
    Boost:Center()
    Boost:SetTextColor( Color(255, 255, 255) )
    Boost:SetContentAlignment(5)
    Boost:Dock(FILL)

    local Yes = vgui.Create("DButton", Panel)
    Yes:SetText("Yes")
    Yes:SetFont("DermaDefault")
    Yes:SetTextColor( Color(255, 255, 255) )
    Yes:SetWide(D_Frame:GetWide() * 0.5 - 14)
    Yes:Dock(LEFT)
    function Yes.Paint(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(47, 49, 54))
        if s.IsHovered() then
            local Hover = Lerp(FrameTime()*5,0,1)
            draw.RoundedBox(0, 0, 0, w, h, Color(66, 70, 77))
        end
    end
    Yes:SetTextColor( Color(255, 255, 255) )
    Yes.DoClick = function()
        camelCaseEnableMulticore()
        D_Frame:Remove()
        surface.PlaySound( "garrysmod/ui_click.wav" )
        chat.AddText("camelCase Multicore enabled!")
    end
end

hook.Add( 'OnPlayerChat', 'camelCase_open_fps', function(ply, strText, bTeam, bDead) 
    if ply == LocalPlayer() and strText == '!fps' then
        OpenWindow()
    end
end)

concommand.Add('camelCase_fps_boost', OpenWindow)