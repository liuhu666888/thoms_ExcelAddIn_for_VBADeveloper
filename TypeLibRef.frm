VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} TypeLibRef 
   Caption         =   "�Q�Ɛݒ�i���j"
   ClientHeight    =   6624
   ClientLeft      =   36
   ClientTop       =   324
   ClientWidth     =   11700
   OleObjectBlob   =   "TypeLibRef.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "TypeLibRef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub UserForm_Initialize()
    TextBox1.Text = vbNullString
    Call ListReset
    Dim w As Workbook
    For Each w In Workbooks
        If Not w Is ThisWorkbook Then
            ComboBox1.AddItem w.name
        End If
    Next
End Sub

Private Sub ListReset()
    ListBox1.Clear
    Dim arr() As Variant
    arr = ReadData
    Dim i As Long
    For i = LBound(arr, 1) To UBound(arr, 1)
        Me.ListBox1.AddItem arr(i, 1)
        Me.ListBox1.List(ListBox1.ListCount - 1, 1) = arr(i, 2)
    Next
End Sub

Function ReadData() As Variant
    If shTypeLib.Cells(1, 1) = "" Then
        MsgBox "�f�[�^������܂���B", vbExclamation, "�m�F"
        MsgBox "�����ݒ�����{���܂��B", vbInformation, "�m�F"
        �����ݒ�
    End If
    ReadData = shTypeLib.Cells(1, 1).CurrentRegion.Value
End Function

Private Sub cmd�N���A_Click()
    UserForm_Initialize
End Sub

Private Sub cmd����_Click()
    Call ListReset
    Dim i As Long
    Do While i < ListBox1.ListCount
        If InStr(1, ListBox1.List(i, 0), TextBox1.Text, vbTextCompare) = 0 Then
            ListBox1.RemoveItem (i)
        Else
            i = i + 1
        End If
    Loop
End Sub

Private Sub cmd�i����_Click()
    Dim i As Long
    Do While i < ListBox1.ListCount
        If InStr(1, ListBox1.List(i, 0), TextBox1.Text, vbTextCompare) = 0 Then
            ListBox1.RemoveItem (i)
        Else
            i = i + 1
        End If
    Loop
End Sub

Private Sub ListBox1_DblClick(ByVal Cancel As MSForms.ReturnBoolean)
    With ListBox1
        ListBox2.AddItem .List(.ListIndex, 0)
        ListBox2.List(ListBox2.ListCount - 1, 1) = .List(.ListIndex, 1)
    End With
End Sub

Private Sub ListBox2_DblClick(ByVal Cancel As MSForms.ReturnBoolean)
    On Error Resume Next '���I����W�N���b�N�����ꍇ�̃G���[�𖳎�
        ListBox2.RemoveItem ListBox2.ListIndex
    On Error GoTo 0
End Sub

Private Sub cmdOK_Click()
    With ListBox2
        If .ListCount > 0 Then
            If ComboBox1.Text <> "" Then
                Dim i As Long, cnt As Long
                For i = 0 To .ListCount - 1
                    On Error Resume Next '�Q�ƕs�G���[�͖ʓ|�Ȃ̂ŃX�L�b�v
                    Workbooks(ComboBox1.Text).VBProject.References.AddFromFile .List(i, 1)
                    If Err.Number = 0 Then cnt = cnt + 1
                    On Error GoTo 0
                Next
                MsgBox "���[�N�u�b�N�u" & Workbooks(ComboBox1.Text).name & "�v��" _
                    & cnt & "���̎Q�Ƃ�ǉ����܂����B", vbInformation, "����"
                Unload Me
            Else
                MsgBox "����̃R���{�{�b�N�X�őΏۂ̃u�b�N��I�����Ă��������B", vbInformation, "�G���["
            End If
        End If
    End With
End Sub

Private Sub cmd�����ݒ�_Click()
    MsgBox "�����ݒ�ł́A���W�X�g������^�C�v���C�u�����̏���ǂݍ��݂܂��B", vbInformation, "�����ݒ�ɂ���"
    MsgBox "����N������A�\�t�g�E�F�A�̃C���X�g�[�����s�����ꍇ�Ɏ��{���Ă��������B", vbInformation, "�����ݒ�ɂ���"
    MsgBox "���̑���͐��b�`���\�b������܂��B", vbInformation, "�����ݒ�ɂ���"
    If vbYes = MsgBox("���s���܂����B", vbInformation + vbYesNo, "�m�F") Then
        Call �����ݒ�
        Call UserForm_Initialize
        MsgBox "�������܂����B", vbInformation, "����"
    Else
        MsgBox "�L�����Z�����܂����B", vbInformation, "���~"
    End If
End Sub

