Attribute VB_Name = "MenuMacros"
Sub �Q�Ɛݒ��() 'R
    TypeLibRef.Show
End Sub

Sub �J�����g�v���W�F�N�g���G�N�X�|�[�g() 'E
    MsgBox "�o�͐��I�����Ă��������B", vbInformation
    Dim savepath: savepath = OpenFolderDialog
    If savepath = "" Then GoTo Cancel_Exit
    
    If CreateObject("Scripting.FileSystemObject").GetFolder(savepath).Files.Count > 0 Then
        If vbYes <> MsgBox( _
            "�t�H���_���Ƀt�@�C�������݂��܂��B" _
            & "�����̃t�@�C���͏㏑������܂������̂܂ܑ��s���܂����H" _
            , vbExclamation + vbYesNo, "�m�F") _
        Then
            GoTo Cancel_Exit
        End If
    End If
        
    Dim vbc As VBComponent
    For Each vbc In Application.VBE.ActiveVBProject.VBComponents
        Select Case vbc.Type
            Case vbext_ct_StdModule
                ext = ".bas"
            Case vbext_ct_ClassModule
                ext = ".cls"
            Case vbext_ct_Document
                ext = ".obj.cls"
            Case vbext_ct_MSForm
                ext = ".frm"
            Case Else
                ext = ".unknown"
        End Select
        vbc.Export savepath & "\" & vbc.name & ext
    Next
    MsgBox "�G�N�X�|�[�g�������܂����B", vbInformation, "����"
Exit Sub
Cancel_Exit:
    MsgBox "�L�����Z�����܂����B", vbInformation, "�L�����Z��"
End Sub

Sub �J���[�p���b�g��\��() 'O
    Application.Visible = False
    With Application.VBE.ActiveCodePane
        ColorPicker.Show
        .Show
    End With
    Application.Visible = True
End Sub

Sub ��A�N�e�B�u�ȃR�[�h�y�C�������() 'C
    Dim C As VBIDE.CodePane
    With ThisWorkbook.VBProject.VBE
        For Each C In .CodePanes
            If Not .ActiveCodePane Is C Then C.Window.Close
        Next
    End With
End Sub

Sub �I�����ꂽ���W���[���̃C���f���g�𒲐�() 'I
    '�v���V�[�W����̃R�����g�������Ă��܂��̂ŗv���P
    Dim sl As Long, sc As Long, el As Long, ec As Long
    Application.VBE.ActiveCodePane.GetSelection sl, sc, el, ec
    Dim SB As StringBuilder: Set SB = New StringBuilder
    With Application.VBE.ActiveCodePane.CodeModule
        Dim startProc As String: startProc = .ProcOfLine(sl, vbext_pk_Proc)
        Dim endProc As String: endProc = .ProcOfLine(el, vbext_pk_Proc)
        If startProc <> "" And endProc <> "" Then
            If startProc = endProc Then
                Dim pKind As vbext_ProcKind
                pKind = CurrentProcKind(startProc, sl, el)
                If pKind <> -1 Then
                    pcount = .ProcCountLines(startProc, pKind)
                    pbodystart = .ProcBodyLine(startProc, pKind)
                    pstart = .ProcStartLine(startProc, pKind)
                    prealcount = pcount - (pbodystart - pstart)
                    SB.AppendLine .Lines(pbodystart, prealcount)
                    .DeleteLines pstart, pcount
                    .InsertLines pstart, Indent(SB.Value)
                Else
                    MsgBox "�v���V�[�W�������ł��܂���B", vbExclamation, "�G���["
                End If
            Else
                MsgBox "�v���V�[�W�������ł��܂���B", vbExclamation, "�G���["
            End If
        Else
            MsgBox "Declarations �̈�ł͎��s�ł��܂���B" & vbNewLine & _
                "�v���V�[�W����Ŏ��s���Ă��������B", vbExclamation, "�G���["
        End If
    End With
End Sub

Sub ���j���[�X�V() 'U
    Main.Auto_Open
End Sub
