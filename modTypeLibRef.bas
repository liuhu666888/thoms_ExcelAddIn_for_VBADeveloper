Attribute VB_Name = "modTypeLibRef"
Option Explicit
Sub �����ݒ�()
    shTypeLib.Cells.Clear
    Call Ref
    Call SheetSort
End Sub

Sub Ref()
    Dim ���W�X�g�� As Object: Set ���W�X�g�� = _
        CreateObject("WbemScripting.SWbemLocator") _
            .ConnectServer(, "root\default") _
                .Get("StdRegProv")

    Const HKCR = &H80000000
    Dim TypeLib�̎q, TypeLib�̑�, �q, ��, �l, �l2
    Dim arr() As String
    ReDim arr(1 To 2, 1 To 1)
    Dim i As Long
    i = 1
    ���W�X�g��.EnumKey HKCR, "TypeLib", TypeLib�̎q
    For Each �q In TypeLib�̎q
        ���W�X�g��.EnumKey HKCR, "TypeLib\" & �q, TypeLib�̑�
        If Not IsNull(TypeLib�̑�) Then
            For Each �� In TypeLib�̑�
                ���W�X�g��.GetStringValue HKCR, "TypeLib\" & �q & "\" & �� & "\0\win32", , �l
                ���W�X�g��.GetStringValue HKCR, "TypeLib\" & �q & "\" & ��, , �l2
                If (Not IsNull(�l2)) And (Not IsNull(�l)) Then
                    shTypeLib.Cells(i, 1) = �l2
                    shTypeLib.Cells(i, 2) = �l
                    i = i + 1
                End If
            Next
        End If
    Next
End Sub

Sub SheetSort()
    With shTypeLib.Sort
        With .SortFields
            .Clear
            .Add Key:=shTypeLib.Range("A1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        End With
        .SetRange shTypeLib.Cells(1, 1).CurrentRegion
        .Header = xlGuess
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
End Sub

